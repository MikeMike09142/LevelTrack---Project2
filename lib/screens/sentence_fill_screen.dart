import 'dart:math';
import 'package:flutter/material.dart';
import '../models/vocab.dart';
import '../state/app_state.dart';
// Admin editor removed
import '../state/tts_service.dart';
import '../state/ads_service.dart';
import '../widgets/completion_sheet.dart';
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
  bool finished = false;
  bool _speaking = false;
  
  void _showTranslation() {
    final String text;
    final vt = current.sentenceTranslationWithBlank;
    final sentenceEn = current.sentenceWithBlank;
    final word = current.word.trim();
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
    _startSession();
  }

  void _startSession() {
    // Only include items with sentence and answer present
    _order = widget.level.items
        .where((e) => e.sentenceWithBlank.trim().isNotEmpty && e.sentenceAnswer.trim().isNotEmpty)
        .toList();
    _order.shuffle(rnd);
    _index = 0;
    finished = _order.isEmpty;
    _prepareRound();
  }

  Future<void> _prepareRound() async {
    if (_index >= _order.length) {
      setState(() => finished = true);
      // Compute XP/rank before
      double _computeEarnedXp(List<Level> levels) {
        double xp = 0;
        for (final l in levels) {
          final int W = l.items.length;
          if (l.flashcardsCompleted) xp += W;
          if (l.imageChoiceCompleted) xp += W * 0.5;
          if (l.sentencesCompleted) xp += W * 0.5;
        }
        return xp;
      }
      final preLevels = List<Level>.from(AppState.instance.levels.value);
      final double preXp = _computeEarnedXp(preLevels);
      const int xpPerRank = 100;
      final int preRank = preXp.floor() ~/ xpPerRank;

      // Mark section complete for this level
      AppState.instance.markSectionComplete(widget.level.number, 'sentences');

      // Show rewarded ad at the end of the section
      await AdsService.instance.showRewardedAfterSection(
        context,
        sectionName: 'sentences',
        levelNumber: widget.level.number,
      );

      // Compute XP/rank after
      final postLevels = List<Level>.from(AppState.instance.levels.value);
      final double postXp = _computeEarnedXp(postLevels);
      final int postRank = postXp.floor() ~/ xpPerRank;
      final bool rankedUp = postRank > preRank;
      const List<String> rankNames = [
        'Explorador',
        'Aprendiz',
        'Descubridor',
        'Iniciante',
        'Continuador',
        'Estudiante',
        'Independiente',
        'Progresivo',
        'Comunicador',
        'Experto Básico',
        'Avanzando',
        'Pre-Bilingüe',
      ];
      final int cappedRankIndex = postRank >= rankNames.length ? rankNames.length - 1 : postRank;
      final String currentRankName = rankNames[cappedRankIndex];
      final int currentRankNumber = cappedRankIndex + 1;

      // Level completion check
      final latestIndex = postLevels.indexWhere((l) => l.number == widget.level.number);
      final bool levelCompleted = latestIndex >= 0
          ? (postLevels[latestIndex].flashcardsCompleted &&
              postLevels[latestIndex].imageChoiceCompleted &&
              postLevels[latestIndex].sentencesCompleted)
          : false;

      await showCompletionSheet(
        context,
        headline: rankedUp ? '¡FELICITACIONES! HAS SUBIDO DE NIVEL' : '¡FELICITACIONES!',
        message:
            (levelCompleted ? 'Nivel ${widget.level.number} completado.\n' : '') +
            'Has completado la sección de oraciones.',
        currentRankNumber: currentRankNumber,
        currentRankName: currentRankName,
        accentColor: Color(widget.level.accentColor),
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
    setState(() {});
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
    }
    // No SnackBar for wrong answers - visual feedback is enough
    
    // Clear the wrong selection after a delay
    if (!correct) {
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
        actions: const [],
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
                                    : null,
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