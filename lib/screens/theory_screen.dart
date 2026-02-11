import 'package:flutter/material.dart';
import '../models/vocab.dart';

class TheoryScreen extends StatelessWidget {
  final Level level;

  const TheoryScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(level.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (level.imageUrl != null && level.imageUrl!.startsWith('asset:'))
               Padding(
                 padding: const EdgeInsets.only(bottom: 24.0),
                 child: Center(
                   child: Image.asset(
                     level.imageUrl!.substring(6),
                     height: 150,
                     fit: BoxFit.contain,
                   ),
                 ),
               ),
            _buildContent(context, level.theory ?? 'No theory content available for this level yet.'),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.check),
                label: const Text('¡Entendido!'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, String content) {
    final List<Widget> widgets = [];
    final lines = content.split('\n');
    
    for (var line in lines) {
      line = line.trim();
      if (line.isEmpty) {
        widgets.add(const SizedBox(height: 12));
        continue;
      }

      if (line.startsWith('# ')) {
        widgets.add(Text(
          line.substring(2),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorLight,
          ),
        ));
      } else if (line.startsWith('## ')) {
        widgets.add(Text(
          line.substring(3),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ));
      } else if (line.startsWith('### ')) {
        widgets.add(Text(
          line.substring(4),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ));
      } else if (line.startsWith('* ') || line.startsWith('- ')) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(
                child: _parseRichText(context, line.substring(2)),
              ),
            ],
          ),
        ));
      } else {
        widgets.add(Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: _parseRichText(context, line),
        ));
      }
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  // Simple parser for **bold** text
  Widget _parseRichText(BuildContext context, String text) {
    final List<InlineSpan> spans = [];
    final RegExp exp = RegExp(r'\*\*(.*?)\*\*');
    int start = 0;
    
    for (final Match match in exp.allMatches(text)) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ));
      start = match.end;
    }
    
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }
    
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5, color: Colors.white70),
        children: spans,
      ),
    );
  }
}
