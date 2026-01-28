import '../data/sample_data.dart' as data;
import '../models/vocab.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'storage_stub.dart'
    if (dart.library.html) 'storage_web.dart'
    if (dart.library.io) 'storage_io.dart';

class AppState {
  static final AppState instance = AppState._();
  AppState._();

  // Observable levels list
  final ValueNotifier<List<Level>> levels = ValueNotifier<List<Level>>(data.levels);

  // Observable flag for ads removal status
  final ValueNotifier<bool> areAdsRemoved = ValueNotifier<bool>(false);

  // Admin mode removed: app runs in standard user mode only.

  void updateLevel(int index, Level updated) {
    final copy = List<Level>.from(levels.value);
    copy[index] = updated;
    levels.value = copy;
    _saveLevels();
  }

  Future<void> init() async {
    final store = getStorage();
    
    // Load ads removal state
    final adsRemovedStr = await store.read(key: 'app_settings');
    if (adsRemovedStr != null && adsRemovedStr.toLowerCase() == 'true') {
      areAdsRemoved.value = true;
    }
    
    final jsonStr = await store.read();
    if (jsonStr != null && jsonStr.isNotEmpty) {
      try {
        final decoded = json.decode(jsonStr) as List<dynamic>;
        final parsed = decoded.map((e) => Level.fromMap(e as Map<String, dynamic>)).toList();
        // Merge persisted levels with sample data so newly added sample items appear
        final merged = _mergeLevels(parsed, data.levels);
        levels.value = merged;
        _saveLevels();
      } catch (_) {
        // If parsing fails, keep sample data.
      }
    }
  }

  void _saveLevels() {
    final store = getStorage();
    final list = levels.value.map((e) => e.toMap()).toList();
    store.write(json.encode(list));
  }

  // Save ads removal state
  Future<void> _saveAdsRemoved() async {
    final store = getStorage();
    await store.write(areAdsRemoved.value.toString(), key: 'app_settings');
  }

  String exportJson() {
    final list = levels.value.map((e) => e.toMap()).toList();
    return json.encode(list);
  }

  // Normalize image URL: strip legacy 'asset:' prefix and trim whitespace.
  String? _normalizeImageUrl(String? url) {
    if (url == null) return null;
    final t = url.trim();
    if (t.isEmpty) return null;
    return t.startsWith('asset:') ? t.substring(6) : t;
  }

  void loadFromJsonString(String jsonStr) {
    try {
      final decoded = json.decode(jsonStr) as List<dynamic>;
      final parsed = decoded.map((e) => Level.fromMap(e as Map<String, dynamic>)).toList();
      // On explicit import, still merge with sample to include any new content
      levels.value = _mergeLevels(parsed, data.levels);
      _saveLevels();
    } catch (_) {
      // ignore invalid payloads
    }
  }

  // Admin utility: reset all levels to bundled sample data
  void resetToSamples() {
    levels.value = List<Level>.from(data.levels);
    _saveLevels();
  }

  // Admin utility: replace one level with the bundled sample version
  void replaceLevelFromSamples(int levelNumber) {
    final int idx = levels.value.indexWhere((l) => l.number == levelNumber);
    final Level? sample = data.levels.firstWhere((l) => l.number == levelNumber, orElse: () => Level(
      title: 'Level $levelNumber', description: '', number: levelNumber, items: const [], accentColor: 0xFF7C4DFF));
    if (idx >= 0 && sample != null) {
      final copy = List<Level>.from(levels.value);
      final Level persisted = copy[idx];
      // Preserve user progress flags when replacing from samples.
      copy[idx] = Level(
        title: sample.title,
        description: sample.description,
        number: sample.number,
        items: sample.items,
        accentColor: sample.accentColor,
        imageUrl: sample.imageUrl,
        version: sample.version,
        flashcardsCompleted: persisted.flashcardsCompleted,
        imageChoiceCompleted: persisted.imageChoiceCompleted,
        sentencesCompleted: persisted.sentencesCompleted,
        adUnlocked: persisted.adUnlocked,
      );
      levels.value = copy;
      _saveLevels();
    }
  }

  // Merge helper: prefer persisted items, add any new sample items by word key.
  List<Level> _mergeLevels(List<Level> persisted, List<Level> samples) {
    final byNumber = {for (final p in persisted) p.number: p};
    final List<Level> result = [];

    for (final sampleLevel in samples) {
      final persistedLevel = byNumber[sampleLevel.number];
      if (persistedLevel == null) {
        // New level added in samples; include it entirely
        result.add(sampleLevel);
        continue;
      }

      // If sample version differs, prefer the bundled sample level entirely.
      // This allows updating levels when sample content changes without requiring manual reset.
      if (sampleLevel.version != null && sampleLevel.version != persistedLevel.version) {
        // Replace content with sample version but keep user progress flags and user's image edits.
        result.add(Level(
          title: sampleLevel.title,
          description: sampleLevel.description,
          number: sampleLevel.number,
          items: sampleLevel.items,
          accentColor: sampleLevel.accentColor,
          imageUrl: _normalizeImageUrl(persistedLevel.imageUrl ?? sampleLevel.imageUrl),
          version: sampleLevel.version,
          flashcardsCompleted: persistedLevel.flashcardsCompleted,
          imageChoiceCompleted: persistedLevel.imageChoiceCompleted,
          sentencesCompleted: persistedLevel.sentencesCompleted,
          adUnlocked: persistedLevel.adUnlocked,
        ));
        continue;
      }

      // Build maps for item-level merging by word key
      final persistedByWord = {for (final it in persistedLevel.items) it.word: it};
      final Set<String> seenWords = {};
      final List<VocabItem> mergedItems = [];

      // Merge all sample items: fill missing fields from sample where persisted exists
      for (final sampleItem in sampleLevel.items) {
        final persistedItem = persistedByWord[sampleItem.word];
        if (persistedItem == null) {
          mergedItems.add(sampleItem);
          seenWords.add(sampleItem.word);
        } else {
          mergedItems.add(VocabItem(
            word: persistedItem.word,
            translation: (persistedItem.translation.isNotEmpty
                ? persistedItem.translation
                : sampleItem.translation),
            sentenceWithBlank: (persistedItem.sentenceWithBlank.isNotEmpty
                ? persistedItem.sentenceWithBlank
                : sampleItem.sentenceWithBlank),
            sentenceAnswer: (persistedItem.sentenceAnswer.isNotEmpty
                ? persistedItem.sentenceAnswer
                : sampleItem.sentenceAnswer),
            sentenceTranslationWithBlank: (persistedItem.sentenceTranslationWithBlank != null && persistedItem.sentenceTranslationWithBlank!.isNotEmpty
                ? persistedItem.sentenceTranslationWithBlank
                : sampleItem.sentenceTranslationWithBlank),
            imageUrl: (persistedItem.imageUrl != null && persistedItem.imageUrl!.isNotEmpty
                ? persistedItem.imageUrl
                : sampleItem.imageUrl),
            emoji: (persistedItem.emoji != null && persistedItem.emoji!.isNotEmpty
                ? persistedItem.emoji
                : sampleItem.emoji),
          ));
          seenWords.add(sampleItem.word);
        }
      }

      // Include any persisted custom items not present in samples
      for (final it in persistedLevel.items) {
        if (!seenWords.contains(it.word)) {
          mergedItems.add(it);
        }
      }

      // Keep persisted level metadata to respect user edits
      result.add(Level(
        title: persistedLevel.title,
        description: persistedLevel.description,
        number: persistedLevel.number,
        items: mergedItems,
        accentColor: persistedLevel.accentColor,
        imageUrl: _normalizeImageUrl(persistedLevel.imageUrl),
        version: persistedLevel.version,
        flashcardsCompleted: persistedLevel.flashcardsCompleted,
        imageChoiceCompleted: persistedLevel.imageChoiceCompleted,
        sentencesCompleted: persistedLevel.sentencesCompleted,
        adUnlocked: persistedLevel.adUnlocked,
      ));
    }

    // Also include any persisted levels not present in samples (custom levels)
    final sampleNumbers = {for (final s in samples) s.number};
    for (final p in persisted) {
      if (!sampleNumbers.contains(p.number)) {
        result.add(p);
      }
    }

    // Sort by level number for consistency
    result.sort((a, b) => a.number.compareTo(b.number));
    // Backfill: ensure every item has a sentenceTranslationWithBlank.
    // If missing or empty, default to the English sentenceWithBlank.
    final List<Level> hydrated = result
        .map((lvl) => Level(
              title: lvl.title,
              description: lvl.description,
              number: lvl.number,
              items: lvl.items
                  .map((it) => VocabItem(
                        word: it.word,
                        translation: it.translation,
                        sentenceWithBlank: it.sentenceWithBlank,
                        sentenceAnswer: it.sentenceAnswer,
                        sentenceTranslationWithBlank: (it.sentenceTranslationWithBlank != null && it.sentenceTranslationWithBlank!.trim().isNotEmpty)
                            ? it.sentenceTranslationWithBlank
                            : it.sentenceWithBlank,
                        imageUrl: _normalizeImageUrl(it.imageUrl),
                        emoji: it.emoji,
                      ))
                  .toList(),
              accentColor: lvl.accentColor,
              imageUrl: _normalizeImageUrl(lvl.imageUrl) ?? 'assets/images/levels/level${lvl.number}.png',
              version: lvl.version,
              flashcardsCompleted: lvl.flashcardsCompleted,
              imageChoiceCompleted: lvl.imageChoiceCompleted,
              sentencesCompleted: lvl.sentencesCompleted,
              adUnlocked: lvl.adUnlocked,
            ))
        .toList();
    return hydrated;
  }

  // Mark a section complete for unlocking review
  void markSectionComplete(int levelNumber, String section) {
    final int idx = levels.value.indexWhere((l) => l.number == levelNumber);
    if (idx < 0) return;
    final copy = List<Level>.from(levels.value);
    final l = copy[idx];
    bool fc = l.flashcardsCompleted;
    bool ic = l.imageChoiceCompleted;
    bool sc = l.sentencesCompleted;
    switch (section) {
      case 'flashcards':
        fc = true;
        break;
      case 'image_choice':
        ic = true;
        break;
      case 'sentences':
        sc = true;
        break;
    }
    copy[idx] = Level(
      title: l.title,
      description: l.description,
      number: l.number,
      items: l.items,
      accentColor: l.accentColor,
      imageUrl: l.imageUrl,
      version: l.version,
      flashcardsCompleted: fc,
      imageChoiceCompleted: ic,
      sentencesCompleted: sc,
      adUnlocked: l.adUnlocked,
    );
    levels.value = copy;
    _saveLevels();
  }

  // Unlock a level via rewarded ad; persists the flag so activities avoid repeated ads
  void unlockLevelByAd(int levelNumber) {
    final int idx = levels.value.indexWhere((l) => l.number == levelNumber);
    if (idx < 0) return;
    final copy = List<Level>.from(levels.value);
    final l = copy[idx];
    if (l.adUnlocked == true) return; // already unlocked
    copy[idx] = Level(
      title: l.title,
      description: l.description,
      number: l.number,
      items: l.items,
      accentColor: l.accentColor,
      imageUrl: l.imageUrl,
      version: l.version,
      flashcardsCompleted: l.flashcardsCompleted,
      imageChoiceCompleted: l.imageChoiceCompleted,
      sentencesCompleted: l.sentencesCompleted,
      adUnlocked: true,
    );
    levels.value = copy;
    _saveLevels();
  }

  // Set ads removed state (for in-app purchase)
  Future<void> setAdsRemoved(bool removed) async {
    areAdsRemoved.value = removed;
    await _saveAdsRemoved();
  }
}