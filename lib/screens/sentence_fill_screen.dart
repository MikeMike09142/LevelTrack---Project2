import 'dart:math';
import 'package:flutter/material.dart';
import '../models/vocab.dart';
import '../state/app_state.dart';
// Admin editor removed
import '../state/tts_service.dart';
import '../state/ads_service.dart';
import '../widgets/completion_sheet.dart';
import '../services/sound_service.dart';
// Review available only from Level screen after all sections complete

class SentenceFillScreen extends StatefulWidget {
  final Level level;
  const SentenceFillScreen({super.key, required this.level});

  @override
  State<SentenceFillScreen> createState() => _SentenceFillScreenState();
}

class _SentenceFillScreenState extends State<SentenceFillScreen> {
  late VocabItem current;
  late List<String> options;
  final rnd = Random();
  String? selected;
  late List<VocabItem> _order;
  int _index = 0;
  int _lives = 5;
  bool finished = false;
  bool _speaking = false;
  bool _hintUsed = false;
  
  void _showTranslation() {
    final String text;
    final vt = current.sentenceTranslationWithBlank;
    final sentenceEn = current.sentenceWithBlank;
    // final word = current.word.trim(); // Unused
    final tr = current.translation.trim();
    final levelNum = widget.level.number;
    if (vt != null && vt.trim().isNotEmpty) {
      // Prefer sentence translation; keep the blank placeholder visible.
      text = vt;
    } else if ((levelNum == 1 || levelNum == 4) && tr.isNotEmpty) {
      // Show a simple translation fallback using the word translation
      // so every level has visible translation content.
      text = tr;
    } else if (sentenceEn.trim().isNotEmpty) {
      text = sentenceEn;
    } else {
      text = 'Translation not available for this sentence.';
    }
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Translation'),
        content: Text(text),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Close')),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SoundService.instance.init();
    _startSession();
  }

  void _startSession() {
    // Only include items with sentence and answer present
    _order = widget.level.items
        .where((e) => e.sentenceWithBlank.trim().isNotEmpty && e.sentenceAnswer.trim().isNotEmpty)
        .toList();
    _order.shuffle(rnd);
    _index = 0;
    _lives = 5;
    finished = _order.isEmpty;
    _prepareRound();
  }

  Future<void> _prepareRound() async {
    if (_index >= _order.length) {
      setState(() => finished = true);

      // Mark section complete for this level
      AppState.instance.markSectionComplete(widget.level.number, 'sentences');

      // Show rewarded ad at the end of the section
      await AdsService.instance.showRewardedAfterSection(
        context,
        sectionName: 'sentences',
        levelNumber: widget.level.number,
      );

      if (!mounted) return;

      // Define messages based on what happened
    String headline = '¡SECCIÓN COMPLETADA!';
    String body = 'Has completado la sección de Oraciones.';
    
    // Level completion message removed as requested

    await showCompletionSheet(
      context,
      headline: headline,
      message: body,
      accentColor: Color(widget.level.accentColor),
      isLevelCompletion: false, // Treat as normal section completion
      onDone: () {
        Navigator.of(context).pop();
      },
      onRestart: () {
        _startSession();
      },
    );
    return;
  }
  final items = widget.level.items;
  current = _order[_index];
  final others = List<VocabItem>.from(items)..remove(current);
  others.shuffle(rnd);
  final distractors = others.take(3).map((e) => e.sentenceAnswer).toList();
  options = [current.sentenceAnswer, ...distractors];
  options.shuffle(rnd);
  selected = null;
  _hintUsed = false;
  setState(() {});
}

Future<void> _useHint() async {
    if (_hintUsed) return;
    final success = await AppState.instance.useHint();
    if (!mounted) return;
    if (success) {
      setState(() {
        _hintUsed = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Pista usada! La respuesta correcta está resaltada.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No tienes pistas. Cómpralas en la Tienda.')),
      );
    }
  }

void _select(String answer) async {
    if (_speaking) return;
    setState(() => selected = answer);
    final correct = answer.toLowerCase() == current.sentenceAnswer.toLowerCase();
    
    if (correct) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Correct!'),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 800),
        ),
      );
      setState(() => _speaking = true);
      final filled = current.sentenceWithBlank.replaceAll('___', current.sentenceAnswer);
      await TtsService.instance.speakTextList([filled]);
      setState(() => _speaking = false);
      _index++;
      _prepareRound();
    } else {
      // Wrong answer
      SoundService.instance.playWrongSound();
      setState(() {
        _lives--;
      });

      if (_lives <= 0) {
        // Game Over logic
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('¡Oh no!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.broken_image, size: 64, color: Colors.redAccent),
                const SizedBox(height: 16),
                const Text(
                  'Te has quedado sin vidas. Debes reiniciar la sección.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Exit screen
                },
                child: const Text('SALIR', style: TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  setState(() {
                    _startSession(); // Restart session
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                child: const Text('REINTENTAR', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
        return;
      }
      
      // Clear the wrong selection after a delay if still alive
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          setState(() {
            selected = null;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isCorrectSelection = !finished &&
        selected != null &&
        selected!.toLowerCase() == current.sentenceAnswer.toLowerCase();
    final sentence = finished
        ? 'Great job! You finished all sentences.'
        : current.sentenceWithBlank.replaceAll('___', isCorrectSelection ? selected! : '_____');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentence Fill'),
        actions: [
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < _lives ? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
                size: 32,
              );
            }),
          ),
          const SizedBox(width: 12),
          ValueListenableBuilder<int>(
            valueListenable: AppState.instance.hints,
            builder: (context, count, _) {
              return TextButton.icon(
                onPressed: finished ? null : _useHint,
                icon: Icon(Icons.lightbulb, size: 32, color: _hintUsed ? Colors.grey : Colors.yellowAccent),
                label: Text('$count', style: const TextStyle(color: Colors.white, fontSize: 20)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        sentence,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: finished ? null : _showTranslation,
                  icon: const Icon(Icons.translate, size: 28),
                  label: const Text('See translation', style: TextStyle(fontSize: 16)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final buttonWidth = constraints.maxWidth;
                return Column(
                  children: [
                    for (final opt in options)
                      Builder(builder: (context) {
                        final bool isSelected = selected == opt;
                        final bool isCorrect = opt.toLowerCase() == current.sentenceAnswer.toLowerCase();
                        final bool isWrong = isSelected && !isCorrect;
                        final bool showHint = _hintUsed && isCorrect;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: SizedBox(
                            width: buttonWidth,
                            child: ElevatedButton(
                              onPressed: finished || _speaking ? null : () {
                                _select(opt);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 24),
                                backgroundColor: isSelected
                                    ? (isWrong ? Colors.redAccent : Theme.of(context).colorScheme.primary)
                                    : (showHint ? Colors.green.withValues(alpha: 0.3) : null),
                                side: showHint ? const BorderSide(color: Colors.green, width: 2) : null,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (isSelected)
                                    Icon(isCorrect ? Icons.check : Icons.close, size: 24, color: Colors.white),
                                  if (isSelected) const SizedBox(width: 8),
                                  Text(
                                    opt,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected ? Colors.white : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  ],
                );
              },
            ),
              if (finished) ...[
                // TTS quick actions removed from finished section per request
              ],
            const Spacer(),
            if (finished)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: _startSession,
                    icon: const Icon(Icons.replay),
                    label: const Text('Restart'),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}