import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../models/vocab.dart';
import '../state/app_state.dart';
import '../state/ads_service.dart';
import 'store_screen.dart';
import 'level_screen.dart';

import '../widgets/intro_tutorial_dialog.dart';

class LearningPathScreen extends StatefulWidget {
  const LearningPathScreen({super.key});

  @override
  State<LearningPathScreen> createState() => _LearningPathScreenState();
}

class _LearningPathScreenState extends State<LearningPathScreen> {
  static int _lockPopupCount = 0;

  @override
  void initState() {
    super.initState();
    // Schedule the tutorial check after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      IntroTutorialDialog.show(context);
    });
  }

  // Quick editor: paste a public image URL and save
  void _editImage(BuildContext context, Level level, int indexInList) async {
    // Show a clean asset path without the "asset:" prefix for easier editing
    String initial = level.imageUrl ?? '';
    if (initial.startsWith('asset:')) {
      initial = initial.substring(6);
    }
    final ctl = TextEditingController(text: initial);
    final String? result = await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Edit Image URL'),
          content: TextField(
            controller: ctl,
            decoration: const InputDecoration(
              hintText: 'Paste link or assets/images/levels/level1.png (.jpg/.jpeg)',
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
            TextButton(onPressed: () => Navigator.of(ctx).pop(ctl.text.trim()), child: const Text('Save')),
          ],
        );
      },
    );
    if (result == null) return;
    // Normalize: if it looks like a network URL keep it; otherwise save as plain asset path.
    // Also strip any accidental leading "asset:" prefix the user might paste.
    String trimmed = result.trim();
    if (trimmed.startsWith('asset:')) {
      trimmed = trimmed.substring(6);
    }
    final bool isWebLink = trimmed.startsWith('http://') || trimmed.startsWith('https://');
    final String newUrl = isWebLink ? trimmed : trimmed;
    final updated = Level(
      title: level.title,
      description: level.description,
      number: level.number,
      items: level.items,
      accentColor: level.accentColor,
      imageUrl: newUrl.isNotEmpty ? newUrl : null,
      version: level.version,
      flashcardsCompleted: level.flashcardsCompleted,
      imageChoiceCompleted: level.imageChoiceCompleted,
      sentencesCompleted: level.sentencesCompleted,
      adUnlocked: level.adUnlocked,
    );
    AppState.instance.updateLevel(indexInList, updated);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Level image updated')),
    );
  }

  // Build a CORS-friendly proxy URL for an external image.
  String _proxyUrl(String original) {
    try {
      final u = Uri.parse(original);
      final String pathWithQuery = u.path + (u.hasQuery ? '?${u.query}' : '');
      final bool isHttps = u.scheme == 'https';
      final String domainPart = '${isHttps ? 'ssl:' : ''}${u.host}$pathWithQuery';
      final String enc = Uri.encodeComponent(domainPart);
      return 'https://images.weserv.nl/?url=$enc';
    } catch (_) {
      // Last-resort placeholder
      return 'https://picsum.photos/seed/fallback-level/120';
    }
  }

  // Retry image using proxy and persist change
  void _retryImageViaProxy(BuildContext context, Level level, int indexInList) {
    final currentUrl = level.imageUrl;
    if (currentUrl == null || currentUrl.isEmpty) return;
    final proxied = _proxyUrl(currentUrl);
    final updated = Level(
      title: level.title,
      description: level.description,
      number: level.number,
      items: level.items,
      accentColor: level.accentColor,
      imageUrl: proxied,
      version: level.version,
      flashcardsCompleted: level.flashcardsCompleted,
      imageChoiceCompleted: level.imageChoiceCompleted,
      sentencesCompleted: level.sentencesCompleted,
      adUnlocked: level.adUnlocked,
    );
    AppState.instance.updateLevel(indexInList, updated);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Retrying image via proxy…')),
    );
  }

  // Switch to the default asset path based on level number and persist
  Future<String?> _findDefaultAssetForLevel(int number) async {
    // Prefer existing asset among png, jpg, jpeg by checking the AssetManifest
    final List<String> candidates = [
      'assets/images/levels/level$number.png',
      'assets/images/levels/level$number.jpg',
      'assets/images/levels/level$number.jpeg',
    ];
    try {
      final String manifestJson = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifest = json.decode(manifestJson) as Map<String, dynamic>;
      for (final p in candidates) {
        if (manifest.containsKey(p)) return p;
      }
    } catch (_) {
      // Ignore errors and fall back
    }
    return null;
  }

  // Switch to the default asset path based on level number and persist
  Future<void> _useDefaultAsset(BuildContext context, Level level, int indexInList) async {
    final String assetPath = await _findDefaultAssetForLevel(level.number) ??
        'assets/images/levels/level${level.number}.png';
    final updated = Level(
      title: level.title,
      description: level.description,
      number: level.number,
      items: level.items,
      accentColor: level.accentColor,
      imageUrl: 'asset:$assetPath',
      version: level.version,
      flashcardsCompleted: level.flashcardsCompleted,
      imageChoiceCompleted: level.imageChoiceCompleted,
      sentencesCompleted: level.sentencesCompleted,
      adUnlocked: level.adUnlocked,
    );
    AppState.instance.updateLevel(indexInList, updated);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Using asset: $assetPath')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Path'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, size: 32),
            tooltip: 'Show Tutorial',
            onPressed: () {
              // Manual trigger forces the dialog to show
              IntroTutorialDialog.show(context, force: true);
            },
          ),
          IconButton(
            tooltip: 'Store',
            icon: const Icon(Icons.store, size: 32),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const StoreScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<List<Level>>(
        valueListenable: AppState.instance.levels,
        builder: (context, values, _) {
          // Compute global XP totals based on provided formula
          double totalXp = 0;
          double earnedXp = 0;
          for (final level in values) {
            final int W = level.items.length;
            totalXp += 2 * W; // W + 0.5W + 0.5W
            if (level.flashcardsCompleted) earnedXp += W;
            if (level.imageChoiceCompleted) earnedXp += W * 0.5;
            if (level.sentencesCompleted) earnedXp += W * 0.5;
          }
          final double overallProgress = totalXp > 0 ? (earnedXp / totalXp).clamp(0.0, 1.0) : 0.0;

          // Derive overall accent from the 15 level accent colors so the
          // top bar matches the per-level palette progression.
          final List<Color> levelPalette = values.map((l) => Color(l.accentColor)).toList();
          final int paletteCount = levelPalette.length;
          int paletteIndex = 0;
          if (paletteCount > 0) {
            paletteIndex = (overallProgress * paletteCount).floor();
            if (paletteIndex >= paletteCount) paletteIndex = paletteCount - 1;
          }
          final Color overallAccent = levelPalette.isNotEmpty ? levelPalette[paletteIndex] : Colors.cyan;

          // Rank system (12 ranks, 100 XP per rank)
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
          // Rank accent palette (maps rank -> solid bar color)
          const List<Color> rankColors = [
            // Start on purple for Explorador
            Color(0xFF7C4DFF), // Explorador (Deep Purple A200)
            // Transition through blues
            Color(0xFF42A5F5), // Aprendiz (Blue 400)
            Color(0xFF1E88E5), // Descubridor (Blue 600)
            Color(0xFF1976D2), // Iniciante (Blue 700)
            // Then move into greens for higher ranks
            Color(0xFF66BB6A), // Continuador (Green 400)
            Color(0xFF43A047), // Estudiante (Green 600)
            Color(0xFF2E7D32), // Independiente (Green 800)
            Color(0xFF4CAF50), // Progresivo (Green 500)
            Color(0xFF00C853), // Comunicador (Green A700)
            Color(0xFF388E3C), // Experto Básico (Green 700)
            Color(0xFF1B5E20), // Avanzando (Green 900)
            Color(0xFF00E676), // Pre-Bilingüe (Green A400)
          ];
          const int xpPerRank = 100;
          final int maxRanks = rankNames.length;
          final int earnedXpInt = earnedXp.floor();
          int rankZeroBased = xpPerRank > 0 ? (earnedXpInt ~/ xpPerRank) : 0;
          if (rankZeroBased >= maxRanks) rankZeroBased = maxRanks - 1;
          final String currentRankName = rankNames[rankZeroBased];
          final int currentRankNumber = rankZeroBased + 1;
          final Color rankAccent = rankColors[rankZeroBased];

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: values.length + 1, // include header item
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          if (index == 0) {
            // Global XP header
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.trending_up, color: Colors.white70),
                      const SizedBox(width: 8),
                      Text(
                        'Overall Progress',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Text(
                        '${earnedXp.round()} / ${totalXp.round()} XP',
                        style: const TextStyle(color: Colors.white70),
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
                      const Spacer(),
                      Text(
                        'Rango $currentRankNumber / $maxRanks',
                        style: const TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Builder(builder: (context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: overallProgress,
                        minHeight: 10,
                        valueColor: AlwaysStoppedAnimation<Color>(overallAccent),
                        backgroundColor: Colors.white24,
                      ),
                    );
                  }),
                  if (!kReleaseMode) ...[
                    const SizedBox(height: 6),
                    Text(
                      'Debug · rankIndex=$rankZeroBased · rankColor=#${rankAccent.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()} · overallIndex=$paletteIndex · overallColor=#${overallAccent.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}',
                      style: const TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                  ],
                  // Removed the XP hint text per request.
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
            onLongPress: !kReleaseMode && levelUnlocked ? () => _editImage(context, level, index - 1) : null,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 96,
                    margin: const EdgeInsets.only(left: 12, right: 8),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(levelUnlocked ? 1.0 : 0.35),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (level.imageUrl != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Builder(builder: (context) {
                          final String url = level.imageUrl!;
                          // Accept both legacy 'asset:' prefixed and plain 'assets/...' paths
                          final bool legacyPrefixed = url.startsWith('asset:');
                          final String normalized = legacyPrefixed ? url.substring(6) : url;
                          final bool isAsset = normalized.startsWith('assets/');
                          if (isAsset) {
                            final String assetPath = normalized;
                            return Image.asset(
                              assetPath,
                              width: 72,
                              height: 72,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stack) => Container(
                                width: 72,
                                height: 72,
                                color: Colors.white10,
                                alignment: Alignment.center,
                                child: const Icon(Icons.broken_image, color: Colors.white54),
                              ),
                            );
                          } else {
                            return Image.network(
                              url,
                              width: 72,
                              height: 72,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stack) => Container(
                                width: 72,
                                height: 72,
                                color: Colors.white10,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.image_not_supported, color: Colors.white54),
                                    const SizedBox(height: 6),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        minimumSize: const Size(0, 0),
                                      ),
                                      onPressed: () => _retryImageViaProxy(context, level, index - 1),
                                      child: const Text('Try proxy', style: TextStyle(fontSize: 11)),
                                    ),
                                    const SizedBox(height: 4),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        minimumSize: const Size(0, 0),
                                      ),
                                      onPressed: () => _useDefaultAsset(context, level, index - 1),
                                      child: const Text('Use asset', style: TextStyle(fontSize: 11)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        }),
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Level ${level.number}', style: const TextStyle(color: Colors.white70)),
                          const SizedBox(height: 4),
                          Text(
                            level.title,
                            style: Theme.of(context).textTheme.titleLarge,
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
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: progress,
                                minHeight: 8,
                                valueColor: AlwaysStoppedAnimation<Color>(accent),
                                backgroundColor: Colors.white24,
                              ),
                            );
                          }),
                          if (!kReleaseMode) ...[
                            const SizedBox(height: 6),
                            Builder(builder: (_) {
                              // Show gating state for easier debugging
                              bool prevFc = false, prevIc = false, prevSc = false;
                              if (!isFirstLevel) {
                                final int prevIdx = values.indexWhere((l) => l.number == (level.number - 1));
                                if (prevIdx >= 0) {
                                  final prev = values[prevIdx];
                                  prevFc = prev.flashcardsCompleted;
                                  prevIc = prev.imageChoiceCompleted;
                                  prevSc = prev.sentencesCompleted;
                                }
                              }
                              return Text(
                                'Debug · unlocked=${levelUnlocked ? 'true' : 'false'} · prevDone=${prevCompleted ? 'true' : 'false'} · prevFlags=[FC:${prevFc ? '1' : '0'} IC:${prevIc ? '1' : '0'} SC:${prevSc ? '1' : '0'}]',
                                style: const TextStyle(color: Colors.white38, fontSize: 11),
                              );
                            }),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (!kReleaseMode && levelUnlocked)
                    IconButton(
                      tooltip: 'Edit Image',
                      icon: const Icon(Icons.edit, color: Colors.white70, size: 20),
                      onPressed: () => _editImage(context, level, index - 1),
                    ),
                ],
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