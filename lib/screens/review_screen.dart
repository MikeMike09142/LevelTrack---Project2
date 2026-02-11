import 'package:flutter/material.dart';
import '../models/vocab.dart';
import '../state/tts_service.dart';

class ReviewScreen extends StatefulWidget {
  final Level level;
  const ReviewScreen({super.key, required this.level});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool _isPlayingAudio = false; // Audio cooldown state

  // Helper to build the sentence with the answer highlighted
  RichText _buildHighlightedSentence(String sentenceWithBlank, String sentenceAnswer, TextStyle? style) {
    final parts = sentenceWithBlank.split('___');
    return RichText(
      text: TextSpan(
        style: style, // Default text style
        children: <TextSpan>[
          TextSpan(text: parts[0]),
          TextSpan(text: sentenceAnswer, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (parts.length > 1) TextSpan(text: parts[1]),
        ],
      ),
    );
  }

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Words'),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: widget.level.items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final item = widget.level.items[i];
            final hasSentence = item.sentenceWithBlank.trim().isNotEmpty;
            final scheme = Theme.of(context).colorScheme;
            final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
              color: scheme.onSecondaryContainer,
            );
            final bodyStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: scheme.onSecondaryContainer,
            );
            final sentenceStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
              color: scheme.onSecondaryContainer.withValues(alpha: 0.9),
            );
            return Card(
              color: scheme.secondaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.word,
                            style: titleStyle,
                          ),
                        ),

                        IconButton(
                          tooltip: 'Hear word',
                          icon: Icon(
                            Icons.volume_up,
                            color: _isPlayingAudio ? Colors.grey : scheme.onSecondaryContainer,
                          ),
                          onPressed: _isPlayingAudio ? null : () => _playAudioWithCooldown(item.word),
                        ),
                        IconButton(
                          tooltip: 'Hear sentence',
                          icon: Icon(
                            Icons.record_voice_over,
                            color: !hasSentence
                                ? Colors.grey
                                : (_isPlayingAudio ? Colors.grey : scheme.onSecondaryContainer),
                          ),
                          onPressed: !hasSentence || _isPlayingAudio
                              ? null
                              : () => _playAudioWithCooldown(item.sentenceWithBlank.replaceAll('___', item.sentenceAnswer)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(item.translation, style: bodyStyle),
                    if (hasSentence) ...[
                      const SizedBox(height: 8),
                      _buildHighlightedSentence(item.sentenceWithBlank, item.sentenceAnswer, sentenceStyle),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}