class Gramer {
  String name;
  String auxiliaryVerb;

  var placeOfUse;
  var adverbsOfTime;
  var positive;
  var negative;
  var question;
  Gramer.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    auxiliaryVerb = data['auxiliaryVerb'];
    placeOfUse = data['placeOfUse'];
    adverbsOfTime = data['adverbsOfTime'];
    positive = data['positive'];
    negative = data['negative'];
    question = data['question'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'auxiliaryVerb': auxiliaryVerb,
      'placeOfUse': placeOfUse,
      'adverbsOfTime': adverbsOfTime,
      'positive': positive,
      'negative': negative,
      'question': question,
    };
  }
}
