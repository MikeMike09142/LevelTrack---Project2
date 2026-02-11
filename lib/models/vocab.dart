class VocabItem {
  final String word;
  final String translation;
  final String sentenceWithBlank; // use "___" as blank placeholder
  final String sentenceAnswer;
  final String? sentenceTranslationWithBlank; // optional translation for the sentence (keep blank as ___)
  final String? imageUrl; // optional image for Image Choice
  final String? emoji; // optional emoji for Image Choice

  const VocabItem({
    required this.word,
    required this.translation,
    required this.sentenceWithBlank,
    required this.sentenceAnswer,
    this.sentenceTranslationWithBlank,
    this.imageUrl,
    this.emoji,
  });

  Map<String, dynamic> toMap() => {
        'word': word,
        'translation': translation,
        'sentenceWithBlank': sentenceWithBlank,
        'sentenceAnswer': sentenceAnswer,
        'sentenceTranslationWithBlank': sentenceTranslationWithBlank,
        'imageUrl': imageUrl,
        'emoji': emoji,
      };

  factory VocabItem.fromMap(Map<String, dynamic> map) => VocabItem(
        word: map['word'] as String,
        translation: map['translation'] as String,
        sentenceWithBlank: map['sentenceWithBlank'] as String,
        sentenceAnswer: map['sentenceAnswer'] as String,
        sentenceTranslationWithBlank: map['sentenceTranslationWithBlank'] as String?,
        imageUrl: map['imageUrl'] as String?,
        emoji: map['emoji'] as String?,
      );
}

class Level {
  final String title;
  final String description;
  final int number;
  final List<VocabItem> items;
  final int accentColor; // ARGB hex, e.g. 0xFF7C4DFF
  final String? imageUrl; // optional preview image
  final int? version; // optional sample data version for auto-refresh
  final String? theory; // NEW: Theory content for the level
  // Completion flags for unlocking review
  final bool flashcardsCompleted;
  final bool imageChoiceCompleted;
  final bool sentencesCompleted;
  // Rewarded ad gating: once unlocked, skip ads within this level
  final bool adUnlocked;

  const Level({
    required this.title,
    required this.description,
    required this.number,
    required this.items,
    required this.accentColor,
    this.imageUrl,
    this.version,
    this.theory,
    this.flashcardsCompleted = false,
    this.imageChoiceCompleted = false,
    this.sentencesCompleted = false,
    this.adUnlocked = false,
  });

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'number': number,
        'items': items.map((e) => e.toMap()).toList(),
      'accentColor': accentColor,
      'imageUrl': imageUrl,
      'version': version,
      'theory': theory,
      'flashcardsCompleted': flashcardsCompleted,
      'imageChoiceCompleted': imageChoiceCompleted,
      'sentencesCompleted': sentencesCompleted,
      'adUnlocked': adUnlocked,
    };

  factory Level.fromMap(Map<String, dynamic> map) => Level(
        title: map['title'] as String,
        description: map['description'] as String,
        number: map['number'] as int,
        items: (map['items'] as List<dynamic>).map((e) => VocabItem.fromMap(e as Map<String, dynamic>)).toList(),
        accentColor: map['accentColor'] as int,
        imageUrl: map['imageUrl'] as String?,
        version: map['version'] as int?,
        theory: map['theory'] as String?,
        flashcardsCompleted: (map['flashcardsCompleted'] as bool?) ?? false,
        imageChoiceCompleted: (map['imageChoiceCompleted'] as bool?) ?? false,
        sentencesCompleted: (map['sentencesCompleted'] as bool?) ?? false,
        adUnlocked: (map['adUnlocked'] as bool?) ?? false,
      );
}