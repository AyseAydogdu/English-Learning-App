class Dictionary {
  String name;
  String translatedName;
  Dictionary(this.name, this.translatedName);
  Dictionary.fromMap(Map<String, dynamic> data) {
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
