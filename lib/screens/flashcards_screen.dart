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
  final Set<int> _mastered = {};
  final Set<int> _mistakesHistory = {};
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

  Future<void> _playAudioWithCooldown(String text, {bool slow = false}) async {
    if (_isPlayingAudio) return; // Prevent multiple simultaneous audio plays
    
    setState(() {
      _isPlayingAudio = true;
    });
    
    try {
      // Use 0.5 for slow speed, default (0.9/1.0) otherwise
      await TtsService.instance.speakTextList([text], rate: slow ? 0.5 : 0.9);
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

    // Mark section complete for this level
    AppState.instance.markSectionComplete(widget.level.number, 'flashcards');

    // Show rewarded ad at the end of the section
    await AdsService.instance.showRewardedAfterSection(
      context,
      sectionName: 'flashcards',
      levelNumber: widget.level.number,
    );

    if (!mounted) return;

    // Define messages based on what happened
    String headline = '¡SECCIÓN COMPLETADA!';
    String body = 'Has completado la sección de Flashcards.';
    
    // Level completion message removed as requested (handled by Rank Up celebration)

    await showCompletionSheet(
      context,
      headline: headline,
      message: '$body\n\nHas repasado ${_mastered.length} tarjetas.',
      accentColor: Color(widget.level.accentColor),
      isLevelCompletion: false, // Treat as normal section completion
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
        title: Text('Flashcards LEVEL ${widget.level.number}'),
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
                              Tooltip(
                                message: 'Mantén presionado para escuchar lento (0.5x)',
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: _isPlayingAudio ? null : () => _playAudioWithCooldown(item.word),
                                  onLongPress: _isPlayingAudio ? null : () => _playAudioWithCooldown(item.word, slow: true),
                                  child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Icon(
                                        Icons.volume_up,
                                        size: 40,
                                        color: _isPlayingAudio ? Colors.grey : Colors.blue,
                                      ),
                                    ),
                                ),
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