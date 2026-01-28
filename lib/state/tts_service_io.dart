import 'dart:async';
import '../models/vocab.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  TtsService._();
  static final TtsService instance = TtsService._();

  final FlutterTts _tts = FlutterTts();
  bool _initialized = false;

  Future<void> _ensureInit() async {
    if (_initialized) return;
    // Configure defaults; English is the learning language in samples.
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.9);
    await _tts.setPitch(1.0);
    // Ensure speak() completes per utterance to sequence multiple texts.
    await _tts.awaitSpeakCompletion(true);
    _initialized = true;
  }

  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (_) {}
  }

  Future<void> speakTextList(List<String> texts) async {
    await _ensureInit();
    for (final t in texts) {
      final text = t.trim();
      if (text.isEmpty) continue;
      // Some devices require a small delay between utterances.
      await _tts.speak(text);
      // Optional micro-delay to avoid clipping on older devices.
      await Future.delayed(const Duration(milliseconds: 80));
    }
  }

  Future<void> speakWordsOfLevel(Level level) async {
    final texts = level.items
        .map((v) => v.word)
        .where((w) => w.trim().isNotEmpty)
        .toList();
    await speakTextList(texts);
  }

  Future<void> speakSentencesOfLevel(Level level) async {
    final texts = level.items
        .map((v) => _buildSentence(v))
        .where((s) => s.trim().isNotEmpty)
        .toList();
    await speakTextList(texts);
  }

  String _buildSentence(VocabItem v) {
    if ((v.sentenceAnswer ?? '').trim().isNotEmpty) {
      return v.sentenceAnswer!;
    }
    if ((v.sentenceWithBlank ?? '').trim().isNotEmpty) {
      return v.sentenceWithBlank!;
    }
    final word = v.word.trim();
    final tr = (v.translation ?? '').trim();
    if (word.isEmpty && tr.isEmpty) return '';
    if (tr.isEmpty) return word;
    return '$word — $tr';
  }
}