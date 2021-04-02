class Subjects {
  Map<String, String> subjects;
  List<String> sentence;

  Subjects(this.subjects, this.sentence);
  Subjects.fromMap(Map<dynamic, dynamic> data) {
    subjects = data['subjects'];

    sentence = data['sentence'];
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'subjects': subjects,
      'sentence': sentence,
    };
  }
}
