class Dictionarys {
  String name;
  String translatedName;
  Dictionarys(this.name, this.translatedName);
  Dictionarys.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    translatedName = data['translatedName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'translatedName': translatedName,
    };
  }
}
