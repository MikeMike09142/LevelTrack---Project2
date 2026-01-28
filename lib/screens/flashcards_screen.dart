import 'package:flutter/material.dart';
import '../models/vocab.dart';
import '../state/tts_service.dart';
import '../state/app_state.dart';
import '../state/ads_service.dart';
import '../widgets/completion_sheet.dart';
import '../widgets/gradient_progress_bar.dart';
// Review available only from Level screen after all sections complete

class FlashcardsScreen extends StatefulWidget {
  final Level level;
  const FlashcardsScreen({super.key, required this.level});

  @override
  State<FlashcardsScreen> createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  // Session state
  List<int> _queue = [];
  Set<int> _mastered = {};
  Set<int> _mistakesHistory = {};
  bool _reviewingWrongOnly = false;
  bool showTranslation = false;
  bool finished = false;
  bool _isPlayingAudio = false; // Audio cooldown state

  @override
  void initState() {
    super.initState();
    _startSession();
  }

  void _startSession() {
    final total = widget.level.items.length;
    _queue = List.generate(total, (i) => i);
    _mastered.clear();
    _mistakesHistory.clear();
    _reviewingWrongOnly = false;
    finished = false;
    showTranslation = false;
  }

  void _markGood() => _advance(correct: true);
  void _markBad() => _advance(correct: false);

  Future<void> _playAudioWithCooldown(String text) async {
    if (_isPlayingAudio) return; // Prevent multiple simultaneous audio plays
    
    setState(() {
      _isPlayingAudio = true;
    });
    
    try {
      await TtsService.instance.speakTextList([text]);
    } finally {
      // Add a small cooldown to prevent rapid clicking
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        setState(() {
          _isPlayingAudio = false;
        });
      }
    }
  }

  void _advance({required bool correct}) {
    if (_queue.isEmpty) return;
    final current = _queue.removeAt(0);

    if (correct) {
      _mastered.add(current);
      // In wrong-only review, mastered items drop out naturally.
    } else {
      // Track mistakes for summary and potential review.
      _mistakesHistory.add(current);
      // During wrong-only review, put wrong card back to end of queue.
      if (_reviewingWrongOnly) {
        _queue.add(current);
      }
    }

    if (_queue.isEmpty) {
      // Phase complete: if we finished the first pass and have mistakes, review them.
      final total = widget.level.items.length;
      final allMastered = _mastered.length >= total;
      if (!_reviewingWrongOnly && _mistakesHistory.isNotEmpty && !allMastered) {
        _queue = _mistakesHistory.toList();
        _reviewingWrongOnly = true;
      }

      if (_queue.isEmpty) {
        _finishLesson(total);
        return;
      }
    }

    setState(() {
      showTranslation = false;
      _isPlayingAudio = false; // Reset audio state when changing cards
    });
  }

  Future<void> _finishLesson(int total) async {
    setState(() => finished = true);
    // Compute XP and rank before completion
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
    AppState.instance.markSectionComplete(widget.level.number, 'flashcards');

    // Show rewarded ad at the end of the section
    await AdsService.instance.showRewardedAfterSection(
      context,
      sectionName: 'flashcards',
      levelNumber: widget.level.number,
    );

    // Compute XP and rank after completion
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

    // Check if level completed (all sections done)
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
          '¡Increíble! Has dominado ${_mastered.length} tarjetas.',
      currentRankNumber: currentRankNumber,
      currentRankName: currentRankName,
      accentColor: Color(widget.level.accentColor),
      onDone: () {
        Navigator.pop(context);
      },
      onRestart: () {
        setState(() {
          _startSession();
          finished = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _queue.isNotEmpty ? _queue.first : 0;
    final item = widget.level.items[currentIndex];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcards'),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Align(
          alignment: Alignment(0, -0.08),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            // Progress indicator (match card width for visual centering)
            SizedBox(
              width: 520,
              child: GradientProgressBar(
                value: _mastered.length / widget.level.items.length,
                height: 6,
                gradientColors: [
                  Color(widget.level.accentColor),
                  Color(widget.level.accentColor),
                ],
                backgroundColor: Colors.white24,
              ),
            ),
            const SizedBox(height: 16),
            Dismissible(
              key: ValueKey('fc_$currentIndex'),
              direction: DismissDirection.horizontal,
                  background: Container(
                    decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(16)),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(16)),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.check, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      // Swipe left → Good
                      _markGood();
                    } else if (direction == DismissDirection.startToEnd) {
                      // Swipe right → Bad
                      _markBad();
                    }
                  },
                  child: SizedBox(
                    width: 520,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => setState(() => showTranslation = !showTranslation),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
                          child: Column(
                            children: [
                              Text(
                                item.word,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 12),
                              IconButton(
                                 icon: Icon(
                                   Icons.volume_up,
                                   size: 40,
                                   color: _isPlayingAudio ? Colors.grey : Colors.blue,
                                 ),
                                 onPressed: _isPlayingAudio ? null : () => _playAudioWithCooldown(item.word),
                               ),
                              const SizedBox(height: 12),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                child: showTranslation
                                    ? Text(
                                        item.translation,
                                        key: const ValueKey('t'),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 22, color: Colors.white70),
                                      )
                                    : const Text(
                                      'Toca la tarjeta para revelar',
                                      key: ValueKey('h'),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white54),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: 520,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        minimumSize: const Size(88, 64),
                      ),
                      onPressed: _markBad,
                      child: const Icon(Icons.close, size: 32),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        minimumSize: const Size(88, 64),
                      ),
                      onPressed: _markGood,
                      child: const Icon(Icons.check, size: 32),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);
  }
}