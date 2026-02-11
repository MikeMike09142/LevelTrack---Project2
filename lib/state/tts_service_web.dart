import 'dart:async';
import 'dart:js_interop';
import 'package:web/web.dart' as web;
import '../models/vocab.dart';

class TtsService {
  TtsService._();
  static final TtsService instance = TtsService._();

  Future<void> stop() async {
    web.window.speechSynthesis.cancel();
  }

  Future<void> speakTextList(List<String> texts) async {
    for (final t in texts) {
      final text = t.trim();
      if (text.isEmpty) continue;
      await _speakWeb(text);
    }
  }

  Future<void> speakWordsOfLevel(Level level) async {
    final texts = level.items.map((v) => v.word).where((w) => w.trim().isNotEmpty).toList();
    await speakTextList(texts);
  }

  Future<void> speakSentencesOfLevel(Level level) async {
    final texts = level.items.map((v) => _buildSentence(v)).where((s) => s.trim().isNotEmpty).toList();
    await speakTextList(texts);
  }

  String _buildSentence(VocabItem v) {
    if (v.sentenceAnswer.trim().isNotEmpty) {
      return v.sentenceAnswer;
    }
    if (v.sentenceWithBlank.trim().isNotEmpty) {
      return v.sentenceWithBlank;
    }
    final word = v.word.trim();
    final tr = v.translation.trim();
    if (word.isEmpty && tr.isEmpty) return '';
    if (tr.isEmpty) return word;
    return '$word — $tr';
  }

  Future<void> _speakWeb(String text) async {
    final synth = web.window.speechSynthesis;
    final utter = web.SpeechSynthesisUtterance(text);
    utter.lang = 'en-US';
    utter.rate = 1.0;
    utter.pitch = 1.0;
    
    final completer = Completer<void>();
    utter.onend = ((web.Event e) {
      if (!completer.isCompleted) completer.complete();
    }).toJS;
    utter.onerror = ((web.Event e) {
      if (!completer.isCompleted) completer.complete();
    }).toJS;
    
    synth.speak(utter);
    await completer.future.timeout(const Duration(seconds: 10), onTimeout: () {});
  }
}