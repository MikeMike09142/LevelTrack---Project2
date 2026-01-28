import 'package:flutter/material.dart';
import '../models/vocab.dart';
import '../state/tts_service.dart';

class MiniReviewList extends StatefulWidget {
  final Level level;
  final double height;
  const MiniReviewList({super.key, required this.level, this.height = 260});

  @override
  State<MiniReviewList> createState() => _MiniReviewListState();
}

class _MiniReviewListState extends State<MiniReviewList> {
  bool _isPlayingAudio = false; // Audio cooldown state

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
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 640),
      child: SizedBox(
        height: widget.height,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ListView.separated(
              itemCount: widget.level.items.length,
              separatorBuilder: (_, __) => const Divider(height: 8),
              itemBuilder: (context, i) {
                final item = widget.level.items[i];
                final sentence = item.sentenceWithBlank.trim().isNotEmpty
                    ? item.sentenceWithBlank.replaceAll('___', item.sentenceAnswer)
                    : null;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.word, style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 2),
                          Text(item.translation, style: Theme.of(context).textTheme.bodySmall),
                          if (sentence != null) ...[
                            const SizedBox(height: 4),
                            Text(sentence, style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Hear word',
                      icon: Icon(
                        Icons.volume_up,
                        color: _isPlayingAudio ? Colors.grey : null,
                      ),
                      onPressed: _isPlayingAudio ? null : () => _playAudioWithCooldown(item.word),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}