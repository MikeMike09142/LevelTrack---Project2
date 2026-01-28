import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:audioplayers/audioplayers.dart' as audio_players;
import 'gradient_progress_bar.dart';
import 'web_audio_player.dart';

Future<void> showCompletionSheet(
  BuildContext context, {
  required String headline,
  required String message,
  required int currentRankNumber,
  required String currentRankName,
  required Color accentColor,
  VoidCallback? onDone,
  VoidCallback? onRestart,
  bool showRank = true,
}) async {
  return showDialog<void>(
    context: context,
    builder: (ctx) => _CompletionDialog(
      headline: headline,
      message: message,
      currentRankNumber: currentRankNumber,
      currentRankName: currentRankName,
      accentColor: accentColor,
      onDone: onDone,
      onRestart: onRestart,
      showRank: showRank,
    ),
  );
}

class _CompletionDialog extends StatefulWidget {
  const _CompletionDialog({
    required this.headline,
    required this.message,
    required this.currentRankNumber,
    required this.currentRankName,
    required this.accentColor,
    this.onDone,
    this.onRestart,
    this.showRank = true,
  });

  final String headline;
  final String message;
  final int currentRankNumber;
  final String currentRankName;
  final Color accentColor;
  final VoidCallback? onDone;
  final VoidCallback? onRestart;
  final bool showRank;

  @override
  State<_CompletionDialog> createState() => _CompletionDialogState();
}

class _CompletionDialogState extends State<_CompletionDialog> {
  late final just_audio.AudioPlayer _player;
  WebAudioPlayer? _nativeWebPlayer; // Native web audio player

  @override
  void initState() {
    super.initState();
    _player = just_audio.AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    if (kIsWeb) {
      // Use native web audio player
      _nativeWebPlayer = WebAudioPlayer();
      try {
        print('Pre-loading audio asset for web using native WebAudioPlayer...');
        await _nativeWebPlayer!.load('assets/assets/audio/congratulations.mp3');
        print('Audio asset pre-loaded successfully for web.');
      } catch (e) {
        print('FATAL: Could not load audio asset for web: $e');
      }
    } else {
      // Keep the robust audio session logic for mobile
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.speech());
      try {
        await _player.setAsset('assets/audio/congratulations.mp3');
      } catch (e) {
        print('FATAL: Could not load audio asset: $e');
      }
    }
  }

  Future<void> _playSoundOnInteraction() async {
    try {
      if (kIsWeb) {
        // Play using the robust double-tap web player
        await _nativeWebPlayer!.play();
      } else {
        final session = await AudioSession.instance;
        await session.setActive(true);
        await _player.seek(Duration.zero); // Rewind to start
        await _player.play();
      }
    } catch (e) {
      print('Error playing sound on interaction: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    _nativeWebPlayer?.dispose(); // Dispose native web player if it exists
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final gradientColors = [
      widget.accentColor.withOpacity(0.95),
      scheme.primary.withOpacity(0.9),
    ];
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 48, // Subtract padding
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          const Icon(Icons.emoji_events, color: Colors.amber, size: 64),
                          const SizedBox(height: 24),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              widget.headline,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (widget.showRank) ...[
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Rango ${widget.currentRankNumber} / 12 · ${widget.currentRankName}',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: GradientProgressBar(
                                value: widget.currentRankNumber / 12.0,
                                height: 12,
                                borderRadius: BorderRadius.circular(12),
                                gradientColors: [
                                  widget.accentColor,
                                  widget.accentColor,
                                ],
                                backgroundColor: Colors.white24,
                              ),
                            ),
                          ],
                          const SizedBox(height: 24),
                          Text(
                            widget.message,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white70),
                          ),
                          const Spacer(),
                          const SizedBox(height: 32),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  // Play sound when user clicks (this should work on web)
                                  await _playSoundOnInteraction();
                                  if (mounted) {
                                    Navigator.pop(context);
                                    widget.onDone?.call();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.check, size: 32, color: Colors.black87),
                                    const SizedBox(width: 8),
                                    Text('Hecho', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black87)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}