import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'web_audio_player.dart';

Future<void> showCompletionSheet(
  BuildContext context, {
  required String headline,
  required String message,
  required Color accentColor,
  VoidCallback? onDone,
  VoidCallback? onRestart,
  bool isLevelCompletion = false,
}) async {
  return showDialog<void>(
    context: context,
    builder: (ctx) => _CompletionDialog(
      headline: headline,
      message: message,
      accentColor: accentColor,
      onDone: onDone,
      onRestart: onRestart,
      isLevelCompletion: isLevelCompletion,
    ),
  );
}

class _CompletionDialog extends StatefulWidget {
  const _CompletionDialog({
    required this.headline,
    required this.message,
    required this.accentColor,
    this.onDone,
    this.onRestart,
    this.isLevelCompletion = false,
  });

  final String headline;
  final String message;
  final Color accentColor;
  final VoidCallback? onDone;
  final VoidCallback? onRestart;
  final bool isLevelCompletion;

  @override
  State<_CompletionDialog> createState() => _CompletionDialogState();
}

class _CompletionDialogState extends State<_CompletionDialog> {
  late final just_audio.AudioPlayer _player;
  WebAudioPlayer? _nativeWebPlayer; // Native web audio player
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    if (widget.isLevelCompletion) {
      _confettiController.play();
    }
    _player = just_audio.AudioPlayer();
    _initAudio().then((_) {
      if (widget.isLevelCompletion && mounted) {
        _playSoundOnInteraction();
      }
    });
  }

  Future<void> _initAudio() async {
    if (kIsWeb) {
      // Use native web audio player
      _nativeWebPlayer = WebAudioPlayer();
      try {
        await _nativeWebPlayer!.load('assets/assets/audio/congratulations.mp3');
      } catch (e) {
        // Silent failure in production
      }
    } else {
      // Keep the robust audio session logic for mobile
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.speech());
      try {
        await _player.setAsset('assets/audio/congratulations.mp3');
      } catch (e) {
        // Silent failure in production
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
      // Silent failure in production
    }
  }

  @override
  void dispose() {
    _player.dispose();
    _nativeWebPlayer?.dispose(); // Dispose native web player if it exists
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final gradientColors = [
      widget.accentColor.withValues(alpha: 0.95),
      scheme.primary.withValues(alpha: 0.9),
    ];
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
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
                          // Rank display removed per user request
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
                                if (mounted) {
                                  // Close the dialog first
                                  Navigator.of(context).pop();
                                  // Then execute the callback if provided
                                  if (widget.onDone != null) {
                                    widget.onDone!();
                                  }
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
      if (widget.isLevelCompletion)
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
        ),
    ],
  ),
);}
}