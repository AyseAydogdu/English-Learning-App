class Proverbs {
  String proverb;
  String translation;
  String meaning;
  Proverbs.fromMap(Map<String, dynamic> data) {
    proverb = data['proverb'];
    translation = data['translation'];
    meaning = data['meaning'];
  }

  Map<String, dynamic> toMap() {
    return {
      'proverb': proverb,
      'translation': translation,
      'meaning': meaning,
    };
  }
}
