import 'dart:math';
import 'package:flutter/material.dart';
import '../models/vocab.dart';
import '../state/app_state.dart';
// Admin editor removed
import '../state/tts_service.dart';
import '../state/ads_service.dart';
import '../widgets/completion_sheet.dart';
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
  bool finished = false;
  bool _speaking = false;
  VocabItem? _selectedItem;
  bool _wasWrong = false;

  @override
  void initState() {
    super.initState();
    _startSession();
  }

  void _startSession() {
    _order = List<VocabItem>.from(widget.level.items);
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
      AppState.instance.markSectionComplete(widget.level.number, 'image_choice');

      // Show rewarded ad at the end of the section
      await AdsService.instance.showRewardedAfterSection(
        context,
        sectionName: 'image_choice',
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
            'Has completado la sección de imágenes.',
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
    // Reset selection state for new round
    _selectedItem = null;
    _wasWrong = false;
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
    }
    // No SnackBar for wrong answers - visual feedback is enough
    
    // Clear the wrong selection after a delay
    if (!correct) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Choice'),
        actions: const [],
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
                    final hasCustomEmoji = opt.emoji != null && opt.emoji!.isNotEmpty;
                    final emoji = hasCustomEmoji ? opt.emoji! : _emojiFor(opt.word);
                    final bool isSelected = _selectedItem == opt;
                    final bool isWrong = isSelected && _wasWrong;
                    final bool isCorrectAnswer = isSelected && !isWrong;
                    
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      color: isWrong ? Colors.red.withOpacity(0.1) : (isCorrectAnswer ? Colors.green.withOpacity(0.1) : null),
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