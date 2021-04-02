class Levels {
  String name;
  String imageUrl;
  Levels(this.name, this.imageUrl);

  static List<Levels> LanguageList = [
    Levels("Kolay", "images/book.png"),
    Levels("Orta", "images/orta.jpg"),
    Levels("İleri", "images/zor.jpg"),
    Levels("Gramer", "images/orta.jpg"),
    Levels("Yds/Yökdil", "images/zor.jpg")
  ];
}
