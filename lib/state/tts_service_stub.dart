import '../models/vocab.dart';

class TtsService {
  TtsService._();
  static final TtsService instance = TtsService._();

  Future<void> stop() async {}

  Future<void> speakTextList(List<String> texts, {double rate = 0.9}) async {}

  Future<void> speakWordsOfLevel(Level level) async {}

  Future<void> speakSentencesOfLevel(Level level) async {}
}