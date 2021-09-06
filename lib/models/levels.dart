class Levels {
  String name;
  String imageUrl;
  Levels(this.name, this.imageUrl);

  static List<Levels> LanguageList = [
    Levels("Kolay", "images/kolay.png"),
    Levels("Orta", "images/orta.png"),
    Levels("İleri", "images/ileri.png"),
    Levels("Gramer", "images/gramer.png"),
    Levels("Yds/Yökdil", "images/yds.png"),
    Levels("Quiz", "images/quiz.png")
  ];
}
