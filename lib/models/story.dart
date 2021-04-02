class Story {
  String story;
  String heading;
  String meaning;
  Story.fromMap(Map<String, dynamic> data) {
    story = data['story'];
    heading = data['heading'];
    meaning = data['meaning'];
  }

  Map<String, dynamic> toMap() {
    return {
      'story': story,
      'heading': heading,
      'meaning': meaning,
    };
  }
}
