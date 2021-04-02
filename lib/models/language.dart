class Language {
  int id;
  String name;

  Language(this.id, this.name);

  static List<Language> getMyLanguage() {
    return <Language>[
      Language(1, "English"),
      Language(2, "Espanol"),
      Language(3, "Français"),
      Language(4, "Türkçe"),
    ];
  }

  static List<Language> getLanguage() {
    return <Language>[
      Language(1, "English"),
      Language(2, "Espanol"),
      Language(3, "Français"),
      Language(4, "Türkçe"),
    ];
  }
}
