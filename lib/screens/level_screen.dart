import 'package:flutter/material.dart';
import '../models/vocab.dart';
import 'flashcards_screen.dart';
import 'image_choice_screen.dart';
import 'sentence_fill_screen.dart';
import 'review_screen.dart';
import 'theory_screen.dart';
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
              toolbarHeight: 120,
              title: Text(
                current.title,
                maxLines: 5,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 6,
                    decoration: BoxDecoration(color: accent.withValues(alpha: 0.35), borderRadius: BorderRadius.circular(6)),
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    children: [
                      Icon(Icons.lock, color: Colors.white70),
                      SizedBox(width: 8),
                      Text('Bloqueado', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Completa el nivel anterior para desbloquear este.'),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Volver'),
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
              // toolbarHeight removed to auto-fit
              title: Text(
                current.title,
                maxLines: 2,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
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
                Text('Elige una actividad', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 24),
                _ActivityTile(
                  title: 'Aprende el concepto',
                  subtitle: 'Explicación del tema del nivel',
                  icon: Icons.lightbulb_outline,
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TheoryScreen(level: current)),
                    );
                  },
                ),
                _ActivityTile(
                  title: 'Flashcards',
                  subtitle: 'Palabra ↔ Traducción',
                  icon: Icons.style,
                  xpReward: current.flashcardsCompleted ? 0 : current.items.length, // Only show XP if not completed
                  onTap: () async {
                    // Inside a level, ads should not repeat. Ad gating happens on level entry.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => FlashcardsScreen(level: current)),
                    );
                  },
                ),
                _ActivityTile(
                  title: 'Selección de Imagen',
                  icon: Icons.image_outlined,
                  enabled: current.flashcardsCompleted,
                  xpReward: current.imageChoiceCompleted ? 0 : (current.items.length * 0.5).round(), // Only show XP if not completed
                  subtitle: current.flashcardsCompleted
                      ? 'Elige la opción correcta (x4)'
                      : '🔒 Completa Flashcards para desbloquear',
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ImageChoiceScreen(level: current)),
                    );
                  },
                ),
                _ActivityTile(
                  title: 'Completar Oración',
                  icon: Icons.text_fields,
                  enabled: current.imageChoiceCompleted,
                  xpReward: current.sentencesCompleted ? 0 : (current.items.length * 0.5).round(), // Only show XP if not completed
                  subtitle: current.imageChoiceCompleted
                      ? 'Coloca la palabra correcta en el espacio'
                      : '🔒 Completa Selección de Imagen para desbloquear',
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SentenceFillScreen(level: current)),
                    );
                  },
                ),
                _ActivityTile(
                  title: 'Repaso de Palabras',
                  subtitle: canReview
                      ? 'Revisa las palabras aprendidas'
                      : 'Completa todas las secciones para desbloquear',
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
  final int xpReward; // New parameter to display XP reward
  const _ActivityTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.enabled = true,
    this.xpReward = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        enabled: enabled,
        leading: Icon(icon, size: 28, color: enabled ? Colors.white : Colors.white38),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18, // Increased from 16
                    ),
                maxLines: 2,
              ),
            ),
            if (xpReward > 0) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.amber.withValues(alpha: 0.5)),
                ),
                child: Text(
                  '+$xpReward XP',
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 13, // Increased from 11
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(
          subtitle, 
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15), // Increased from default (~14)
        ),
        trailing: Icon(enabled ? Icons.chevron_right : Icons.lock, color: enabled ? Colors.white70 : Colors.white38),
        onTap: enabled ? onTap : null,
      ),
    );
  }
}

// Editor moved to separate file: LevelEditScreen