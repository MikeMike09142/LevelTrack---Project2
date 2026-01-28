import 'package:flutter/material.dart';
import '../models/vocab.dart';
import '../state/tts_service.dart';
import 'flashcards_screen.dart';
import 'image_choice_screen.dart';
import 'sentence_fill_screen.dart';
import 'review_screen.dart';
// Admin mode removed; no ad gating or admin UI here.
// Removed unused admin imports.
import '../state/app_state.dart';
// import 'level_edit_screen.dart'; // Admin editor removed

class LevelScreen extends StatelessWidget {
  final Level level;
  final int index;
  const LevelScreen({super.key, required this.level, required this.index});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Level>>(
      valueListenable: AppState.instance.levels,
      builder: (context, values, _) {
        final current = values[index];
        final accent = Color(current.accentColor);
        // Route guard: require previous level completed before entering this level
        final bool isFirstLevel = current.number == 1;
        bool prevCompleted = true;
        if (!isFirstLevel) {
          final int prevIdx = values.indexWhere((l) => l.number == (current.number - 1));
          if (prevIdx >= 0) {
            final prev = values[prevIdx];
            prevCompleted = prev.flashcardsCompleted && prev.imageChoiceCompleted && prev.sentencesCompleted;
          } else {
            prevCompleted = false;
          }
        }
        final bool levelUnlocked = isFirstLevel || prevCompleted;
        // Helpful console log while we debug gating
        // ignore: avoid_print
        debugPrint('Level ${current.number} unlocked=$levelUnlocked prevCompleted=$prevCompleted');

        if (!levelUnlocked) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Level ${current.number}: ${current.title}'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 6,
                    decoration: BoxDecoration(color: accent.withOpacity(0.35), borderRadius: BorderRadius.circular(6)),
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    children: [
                      Icon(Icons.lock, color: Colors.white70),
                      SizedBox(width: 8),
                      Text('Locked', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Complete the previous level to unlock this one.'),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                  ),
                ],
              ),
            ),
          );
        }
        final allDone = (current.flashcardsCompleted == true) &&
            (current.imageChoiceCompleted == true) &&
            (current.sentencesCompleted == true);
        // Allow review when unlocked via rewarded ad as well.
        final canReview = allDone || current.adUnlocked;
        return Scaffold(
          appBar: AppBar(
            title: Text('Level ${current.number}: ${current.title}'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 6,
                  decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(6)),
                ),
                const SizedBox(height: 16),
                Text('Choose an activity', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 24),
                _ActivityTile(
                  title: 'Flashcards',
                  subtitle: 'Word ↔ Translation',
                  icon: Icons.style,
                  onTap: () async {
                    // Inside a level, ads should not repeat. Ad gating happens on level entry.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => FlashcardsScreen(level: current)),
                    );
                  },
                ),
                _ActivityTile(
                  title: 'Image Choice',
                  icon: Icons.image_outlined,
                  enabled: current.flashcardsCompleted,
                  subtitle: current.flashcardsCompleted
                      ? 'Pick the right option (x4)'
                      : '🔒 Complete Flashcards to unlock',
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ImageChoiceScreen(level: current)),
                    );
                  },
                ),
                _ActivityTile(
                  title: 'Sentence Fill',
                  icon: Icons.text_fields,
                  enabled: current.imageChoiceCompleted,
                  subtitle: current.imageChoiceCompleted
                      ? 'Put the right word in the blank'
                      : '🔒 Complete Image Choice to unlock',
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SentenceFillScreen(level: current)),
                    );
                  },
                ),
                _ActivityTile(
                  title: 'Review Words',
                  subtitle: canReview
                      ? 'Browse learned words for this level'
                      : 'Complete all sections to unlock',
                  icon: Icons.library_books,
                  enabled: canReview,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ReviewScreen(level: current)),
                  ),
                ),
              ],
            ),
          ),
          // Admin editor floating action button removed.
        );
      },
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;
  const _ActivityTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        enabled: enabled,
        leading: Icon(icon, size: 28, color: enabled ? Colors.white : Colors.white38),
        title: Text(title, style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        trailing: Icon(enabled ? Icons.chevron_right : Icons.lock, color: enabled ? Colors.white70 : Colors.white38),
        onTap: enabled ? onTap : null,
      ),
    );
  }
}

// Editor moved to separate file: LevelEditScreen