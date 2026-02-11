import 'package:flutter/material.dart';
import '../models/vocab.dart';
import '../state/app_state.dart';
import 'store_screen.dart';
import 'level_screen.dart';

import '../widgets/intro_tutorial_dialog.dart';
import '../widgets/completion_sheet.dart';
import '../widgets/gradient_progress_bar.dart';
import '../main.dart'; // for routeObserver

class LearningPathScreen extends StatefulWidget {
  const LearningPathScreen({super.key});

  @override
  State<LearningPathScreen> createState() => _LearningPathScreenState();
}

class _LearningPathScreenState extends State<LearningPathScreen> with RouteAware {
  static int _lockPopupCount = 0;
  
  // Rank system (15 ranks to match 15 levels)
  static const List<String> rankNames = [
    'Explorador',      // Lvl 1
    'Aprendiz',        // Lvl 2
    'Descubridor',     // Lvl 3
    'Iniciante',       // Lvl 4
    'Continuador',     // Lvl 5
    'Estudiante',      // Lvl 6
    'Independiente',   // Lvl 7
    'Progresivo',      // Lvl 8
    'Comunicador',     // Lvl 9
    'Experto Básico',  // Lvl 10
    'Avanzando',       // Lvl 11
    'Pre-Bilingüe',    // Lvl 12
    'Fluido',          // Lvl 13
    'Experto',         // Lvl 14
    'Maestro',         // Lvl 15
  ];

  // Rank accent palette (maps rank -> solid bar color)
  static const List<Color> rankColors = [
    Color(0xFF7C4DFF), // Explorador
    Color(0xFF42A5F5), // Aprendiz
    Color(0xFF1E88E5), // Descubridor
    Color(0xFF1976D2), // Iniciante
    Color(0xFF66BB6A), // Continuador
    Color(0xFF43A047), // Estudiante
    Color(0xFF2E7D32), // Independiente
    Color(0xFF4CAF50), // Progresivo
    Color(0xFF00C853), // Comunicador
    Color(0xFF388E3C), // Experto Básico
    Color(0xFF1B5E20), // Avanzando
    Color(0xFF00E676), // Pre-Bilingüe
    Color(0xFFFFD600), // Fluido (Gold)
    Color(0xFFFFAB00), // Experto (Amber)
    Color(0xFFFF6D00), // Maestro (Orange)
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Called when the top route has been popped off, and the current route shows up.
    _checkForRankUp();
  }

  void _checkForRankUp() {
    final values = AppState.instance.levels.value;
    int completedLevelsCount = 0;
    for (final level in values) {
       if (level.flashcardsCompleted && level.imageChoiceCompleted && level.sentencesCompleted) {
         completedLevelsCount++;
       }
    }
    
    final int maxRanks = rankNames.length;
    // Rank is capped at maxRanks - 1
    int rankZeroBased = completedLevelsCount; 
    if (rankZeroBased >= maxRanks) rankZeroBased = maxRanks - 1;

    // Check for Rank Up Celebration
    if (rankZeroBased > AppState.instance.lastSeenRank) {
       final int newRank = rankZeroBased;
       // We are already on the main screen, so we can show it immediately (or post frame)
       WidgetsBinding.instance.addPostFrameCallback((_) {
         if (newRank > AppState.instance.lastSeenRank) {
           AppState.instance.setLastSeenRank(newRank);
           _showRankCelebration(context, newRank);
         }
       });
    }

    // Check for Final App Completion (All 15 levels done)
    // completedLevelsCount is derived from 'values' in _checkForRankUp scope?
    // Wait, I need to recalculate completedLevelsCount here as it's local to build usually.
    // Re-computing it here.
    if (completedLevelsCount >= 15 && !AppState.instance.appCompletionShown) {
       WidgetsBinding.instance.addPostFrameCallback((_) {
         if (!AppState.instance.appCompletionShown) {
           _showAppCompletionDialog(context);
         }
       });
    }
  }

  @override
  void initState() {
    super.initState();
    // Schedule the tutorial check after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      IntroTutorialDialog.show(context);
    });
  }

  void _showRankCelebration(BuildContext context, int rankIndex) {
    if (!mounted) return;
    if (rankIndex < 0 || rankIndex >= rankNames.length) return;
    
    final String rankName = rankNames[rankIndex];
    
    // Use the accent color of the level corresponding to this rank (the "new level reached")
    // Rank 0 -> Level 1, Rank 1 -> Level 2, etc.
    final levels = AppState.instance.levels.value;
    final Color accent;
    if (rankIndex < levels.length) {
      accent = Color(levels[rankIndex].accentColor);
    } else {
      // Fallback to rank palette or Amber
      accent = (rankIndex < rankColors.length) ? rankColors[rankIndex] : Colors.amber;
    }

    showCompletionSheet(
      context,
      headline: '¡NUEVO RANGO ALCANZADO!',
      message: '¡Felicidades! Ahora eres $rankName.',
      accentColor: accent,
      isLevelCompletion: true, // Trigger confetti and sound
      // No onRestart provided, so only "CONTINUAR" button will show
    );
  }

  void _showAppCompletionDialog(BuildContext context) {
    // Mark as shown immediately so it doesn't loop if the user dismisses it
    AppState.instance.setAppCompletionShown(true);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.celebration, color: Colors.amber, size: 32),
            SizedBox(width: 12),
            Expanded(child: Text('¡Gracias por aprender con nosotros!', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¡Has completado los 15 niveles!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(height: 16),
              Text(
                'Muchas gracias por haber participado y usado nuestra aplicación. Esperamos que te haya sido de gran ayuda en tu camino de aprendizaje.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Si deseas apoyar el desarrollo de futuras actualizaciones o tienes sugerencias, por favor déjanos un comentario y calificación en la Play Store.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '¡Tu opinión es muy valiosa para nosotros!',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('CERRAR', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton.icon(
            onPressed: () {
              // In a real app, this would launch the store URL.
              // For now, we just close the dialog as we don't have the package 'url_launcher' or a real ID.
              Navigator.of(ctx).pop();
            },
            icon: const Icon(Icons.star),
            label: const Text('IR A PLAY STORE'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100, // Wider/bigger header
        title: const Text(
          'LevelUP English',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Tutorial',
            icon: const Icon(Icons.help_outline, color: Colors.white, size: 28),
            onPressed: () => IntroTutorialDialog.show(context, force: true),
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Tienda',
            icon: const Icon(Icons.diamond, color: Colors.amber, size: 28),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const StoreScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: ValueListenableBuilder<List<Level>>(
        valueListenable: AppState.instance.levels,
        builder: (context, values, _) {
          // Compute global XP totals and Gradient Stops
          double totalXp = 0;
          double earnedXp = 0;
          int totalWordsLearned = 0;
          
          List<Color> gradientColors = [];
          List<double> gradientStops = [];
          double currentXpAccumulator = 0;
          
          // Calculate total possible XP first to normalize stops
          double grandTotalXp = 0;
          for (final l in values) {
            grandTotalXp += 2.0 * l.items.length;
          }

          for (final level in values) {
            final int W = level.items.length;
            final double levelMaxXp = 2.0 * W;
            
            // XP Stats
            totalXp += levelMaxXp;
            if (level.flashcardsCompleted) earnedXp += W;
            if (level.imageChoiceCompleted) earnedXp += W * 0.5;
            if (level.sentencesCompleted) earnedXp += W * 0.5;

            if (level.flashcardsCompleted && level.imageChoiceCompleted && level.sentencesCompleted) {
              totalWordsLearned += W;
            }
            
            // Gradient Building (Hard stops for segmented look)
            if (grandTotalXp > 0) {
               final double start = currentXpAccumulator / grandTotalXp;
               final double end = (currentXpAccumulator + levelMaxXp) / grandTotalXp;
               final Color c = Color(level.accentColor);
               
               gradientColors.add(c);
               gradientStops.add(start);
               gradientColors.add(c);
               gradientStops.add(end);
               
               currentXpAccumulator += levelMaxXp;
            }
          }
          
          final double overallProgress = totalXp > 0 ? (earnedXp / totalXp).clamp(0.0, 1.0) : 0.0;
          
          if (gradientColors.isEmpty) {
             gradientColors = [Colors.grey, Colors.grey];
             gradientStops = [0.0, 1.0];
          }

          // Derive overall accent for the swatch (current active level color)
          final List<Color> levelPalette = values.map((l) => Color(l.accentColor)).toList();
          final int paletteCount = levelPalette.length;
          int paletteIndex = 0;
          if (paletteCount > 0) {
            // Find which level we are currently traversing based on XP
            // Reuse logic? Or just use the simple map
            // The simple map assumes equal weight, which is WRONG if levels have different XP.
            // Let's improve paletteIndex to reflect actual level.
            double xpSearch = 0;
            for (int i = 0; i < values.length; i++) {
               final double lvlXp = 2.0 * values[i].items.length;
               if (earnedXp < xpSearch + lvlXp) {
                 paletteIndex = i;
                 break;
               }
               xpSearch += lvlXp;
               if (i == values.length - 1) paletteIndex = i; // Capped at last
            }
          }
          final Color overallAccent = levelPalette.isNotEmpty ? levelPalette[paletteIndex] : Colors.cyan;

          // Determine Rank based on HIGHEST UNLOCKED LEVEL (or levels completed).
          // If user is on Level 3 (2 completed), they should be Rank 3 ("Descubridor").
          // Rank index = number of fully completed levels.
          // Example: 0 completed -> Rank 0 (Explorador) -> "1/15"
          //          2 completed -> Rank 2 (Descubridor) -> "3/15"
          int completedLevelsCount = 0;
          for (final level in values) {
             if (level.flashcardsCompleted && level.imageChoiceCompleted && level.sentencesCompleted) {
               completedLevelsCount++;
             }
          }
          
          final int maxRanks = rankNames.length;
          // Rank is capped at maxRanks - 1
          int rankZeroBased = completedLevelsCount; 
          if (rankZeroBased >= maxRanks) rankZeroBased = maxRanks - 1;

          // Check for Rank Up Celebration (ONLY if this route is current)
          // Logic moved to didPopNext to prevent overlapping dialogs.
          // We no longer check here in build() to avoid triggering while other screens are active.


          final String currentRankName = rankNames[rankZeroBased];
          // final Color rankAccent = rankColors[rankZeroBased]; // Unused

          // Next rank XP logic is less relevant now, but we can keep it as "XP to next level"
          // or just show total XP.
          // Let's keep showing Total XP vs "Max Potential XP".
          // Or just show "XP: <current>"


          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: values.length + 1, // include header item
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              if (index == 0) {
                // Header Card
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24, width: 1.5), // Subtle lighter border
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.trending_up, color: Colors.white70),
                          const SizedBox(width: 8),
                          Text(
                            'Tu Progreso',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.military_tech, color: Colors.white70, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            'Rango: $currentRankName',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(width: 8),
                          // Visual swatch to confirm the computed overall accent color
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: overallAccent,
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.white24),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Palabras aprendidas: $totalWordsLearned  ·  XP Total: ${earnedXp.toInt()}',
                        style: const TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                      const SizedBox(height: 12),
                  Builder(builder: (context) {
                    return GradientProgressBar(
                      value: overallProgress,
                      height: 10,
                      gradientColors: gradientColors,
                      stops: gradientStops,
                      fixedGradient: true,
                      backgroundColor: Colors.white24,
                    );
                  }),
                ],
              ),
            );
          }
          final Level level = values[index - 1];
          // Level gating: Level 1 unlocked; each subsequent level requires all 3 sections complete in the previous level.
          final bool isFirstLevel = level.number == 1;
          bool prevCompleted = true;
          if (!isFirstLevel) {
            final int prevIdx = values.indexWhere((l) => l.number == (level.number - 1));
            if (prevIdx >= 0) {
              final prev = values[prevIdx];
              prevCompleted = prev.flashcardsCompleted && prev.imageChoiceCompleted && prev.sentencesCompleted;
            } else {
              prevCompleted = false;
            }
          }
          final bool levelUnlocked = isFirstLevel || prevCompleted;
          final accent = Color(level.accentColor);
          return InkWell(
            onTap: levelUnlocked
                ? () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => LevelScreen(level: level, index: index - 1),
                      ),
                    );
                  }
                : () {
                    if (_lockPopupCount < 2) {
                      _lockPopupCount++;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('🔒 Completa el nivel anterior para desbloquear')),
                      );
                    }
                  },
            onLongPress: null,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24, width: 1.5), // Subtle lighter border
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 6,
                      margin: const EdgeInsets.only(left: 12, right: 8),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: levelUnlocked ? 1.0 : 0.35),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (level.imageUrl != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0).copyWith(right: 12),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white, // Uniform white background
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Builder(builder: (context) {
                                  final String url = level.imageUrl!;
                                  // Accept both legacy 'asset:' prefixed and plain 'assets/...' paths
                                  final bool legacyPrefixed = url.startsWith('asset:');
                                  final String normalized = legacyPrefixed ? url.substring(6) : url;
                                  final bool isAsset = normalized.startsWith('assets/');
                                  if (isAsset) {
                                    return Image.asset(
                                      normalized,
                                      fit: BoxFit.cover, // Fill the square uniformly
                                      errorBuilder: (context, error, stack) => Container(
                                        color: Colors.white10,
                                        alignment: Alignment.center,
                                        child: const Icon(Icons.broken_image, color: Colors.black54),
                                      ),
                                    );
                                  } else {
                                    return Image.network(
                                      url,
                                      fit: BoxFit.cover, // Fill the square uniformly
                                      errorBuilder: (context, error, stack) => Container(
                                        color: Colors.white10,
                                        alignment: Alignment.center,
                                        child: const Icon(Icons.image_not_supported, color: Colors.black54),
                                      ),
                                    );
                                  }
                                }),
                                // Completed Overlay
                                if (level.flashcardsCompleted && level.imageChoiceCompleted && level.sentencesCompleted)
                                  Container(
                                    color: Colors.black.withValues(alpha: 0.4),
                                    child: const Center(
                                      child: Icon(Icons.check_circle, color: Colors.greenAccent, size: 32),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nivel ${level.number}', style: const TextStyle(color: Colors.white70)),
                          const SizedBox(height: 4),
                          Text(
                            level.title,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            softWrap: true,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  level.description,
                                  style: Theme.of(context).textTheme.titleMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                              if (!levelUnlocked)
                                const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Icon(Icons.lock, color: Colors.white54, size: 18),
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Builder(builder: (context) {
                            final int completedSections = (level.flashcardsCompleted ? 1 : 0) +
                                (level.imageChoiceCompleted ? 1 : 0) +
                                (level.sentencesCompleted ? 1 : 0);
                            final double progress = completedSections / 3.0;
                            final int percentage = (progress * 100).round();
                            return Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: LinearProgressIndicator(
                                      value: progress,
                                      minHeight: 8,
                                      valueColor: AlwaysStoppedAnimation<Color>(accent),
                                      backgroundColor: Colors.white24,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '$percentage%',
                                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
        },
      ),
    );
  }
}