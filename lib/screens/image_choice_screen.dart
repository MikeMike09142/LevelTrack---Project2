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

class ImageChoiceScreen extends StatefulWidget {
  final Level level;
  const ImageChoiceScreen({super.key, required this.level});

  @override
  State<ImageChoiceScreen> createState() => _ImageChoiceScreenState();
}

class _ImageChoiceScreenState extends State<ImageChoiceScreen> {
  late VocabItem target;
  late List<VocabItem> options;
  final rnd = Random();
  late List<VocabItem> _order;
  int _index = 0;
  int _lives = 5;
  bool finished = false;
  bool _speaking = false;
  VocabItem? _selectedItem;
  bool _wasWrong = false;
  final Set<VocabItem> _eliminated = {};

  @override
  void initState() {
    super.initState();
    SoundService.instance.init();
    _startSession();
  }

  void _startSession() {
    _order = List<VocabItem>.from(widget.level.items);
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
      AppState.instance.markSectionComplete(widget.level.number, 'image_choice');

      // Show rewarded ad at the end of the section
      await AdsService.instance.showRewardedAfterSection(
        context,
        sectionName: 'image_choice',
        levelNumber: widget.level.number,
      );

      if (!mounted) return;

      // Define messages based on what happened
      String headline = '¡SECCIÓN COMPLETADA!';
      String body = 'Has completado la sección de Imágenes.';
      
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
    // Reset selection state for new round
    _selectedItem = null;
    _wasWrong = false;
    _eliminated.clear();
    target = _order[_index];
    final others = List<VocabItem>.from(items)..remove(target);
    others.shuffle(rnd);
    options = [target, ...others.take(3)].toList();

    // Ensure we always have 4 options even if the level has <4 items
    if (options.length < 4) {
      // Try to pad with remaining unique items first
      final filler = List<VocabItem>.from(items)
        ..removeWhere((e) => options.contains(e));
      filler.shuffle(rnd);
      while (options.length < 4 && filler.isNotEmpty) {
        options.add(filler.removeAt(0));
      }
      // If still short (dataset too small), allow duplicates to reach 4
      while (options.length < 4 && items.isNotEmpty) {
        options.add(items[rnd.nextInt(items.length)]);
      }
    }

    options.shuffle(rnd);
    setState(() {});
  }

  Future<void> _useHint() async {
    if (_eliminated.isNotEmpty) return; // Already used hint
    
    // Find wrong options that are not yet eliminated (though _eliminated is empty initially)
    final wrongOptions = options.where((o) => o != target).toList();
    if (wrongOptions.isEmpty) return;
    
    final success = await AppState.instance.useHint();
    if (!mounted) return;

    if (success) {
      wrongOptions.shuffle(rnd);
      // Eliminate up to 2 wrong options
      final toEliminate = wrongOptions.take(2);
      setState(() {
        _eliminated.addAll(toEliminate);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Pista usada! Se han eliminado opciones incorrectas.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No tienes pistas. Cómpralas en la Tienda.')),
      );
    }
  }

  void _select(VocabItem item) async {
    if (_speaking) return;
    final correct = item == target;
    
    setState(() {
      _selectedItem = item;
      _wasWrong = !correct;
    });
    
    if (correct) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Correct!'),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 800),
        ),
      );
      setState(() => _speaking = true);
      await TtsService.instance.speakTextList([target.word]);
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
            _selectedItem = null;
            _wasWrong = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (finished) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.level.title),
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
                onPressed: finished || _eliminated.isNotEmpty ? null : _useHint,
                icon: Icon(Icons.lightbulb, size: 32, color: (_eliminated.isNotEmpty) ? Colors.grey : Colors.yellowAccent),
                label: Text('$count', style: const TextStyle(color: Colors.white, fontSize: 20)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (!finished)
              Text('Choose the image for: "${target.word}"', style: Theme.of(context).textTheme.titleLarge)
            else
              Text('Lesson complete!', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            if (!finished)
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: options.length,
                  itemBuilder: (context, i) {
                    final opt = options[i];
                    final bool isEliminated = _eliminated.contains(opt);
                    
                    if (isEliminated) {
                      return const Card(
                        color: Colors.transparent,
                        elevation: 0,
                      );
                    }

                    final hasCustomEmoji = opt.emoji != null && opt.emoji!.isNotEmpty;
                    final emoji = hasCustomEmoji ? opt.emoji! : _emojiFor(opt.word);
                    final bool isSelected = _selectedItem == opt;
                    final bool isWrong = isSelected && _wasWrong;
                    final bool isCorrectAnswer = isSelected && !isWrong;
                    
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      color: isWrong ? Colors.red.withValues(alpha: 0.1) : (isCorrectAnswer ? Colors.green.withValues(alpha: 0.1) : null),
                      child: InkWell(
                        onTap: _speaking ? null : () => _select(opt),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  hasCustomEmoji
                                      ? Center(
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              // Scale emoji to card size so it doesn't appear too small
                                              final size = (constraints.maxWidth + constraints.maxHeight) * 0.25;
                                              return FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(emoji, style: TextStyle(fontSize: size.clamp(64, 140))),
                                              );
                                            },
                                          ),
                                        )
                                      : (opt.imageUrl != null && opt.imageUrl!.isNotEmpty
                                          ? Image.network(opt.imageUrl!, fit: BoxFit.cover)
                                          : Center(
                                              child: LayoutBuilder(
                                                builder: (context, constraints) {
                                                  final size = (constraints.maxWidth + constraints.maxHeight) * 0.25;
                                                  return FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(emoji, style: TextStyle(fontSize: size.clamp(64, 140))),
                                                  );
                                                },
                                              ),
                                            )),
                                  if (isSelected)
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Icon(
                                        isWrong ? Icons.close : Icons.check,
                                        color: isWrong ? Colors.red : Colors.green,
                                        size: 32,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                opt.translation,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle, size: 64, color: Colors.green),
                      const SizedBox(height: 12),
                      Text('You finished all words!', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 16),
                      // TTS quick actions removed from finished view per request
                      // Mini review list removed; review available from Level screen only
                    ],
                  ),
                ),
              ),
            if (finished) 
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
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

  String _emojiFor(String word) {
    switch (word.toLowerCase()) {
      case 'play':
        return '🎮';
      case 'eat':
        return '🍽️';
      case 'read':
        return '📚';
      case 'run':
        return '🏃';
      case 'write':
        return '✍️';
      case 'in':
        return '📦';
      case 'on':
        return '🧾';
      case 'under':
        return '🛏️';
      case 'between':
        return '↔️';
      case 'behind':
        return '🌳';
      default:
        return '🔤';
    }
  }
}