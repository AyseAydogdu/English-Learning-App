class Yds {
  int id;
  String name;

  Yds(this.id, this.name);

  static List<Yds> getYds() {
    return <Yds>[
      Yds(0, "Phrasal Verb (Deyimsel Fiiller)"),
      Yds(1, "Conjunction (Bağlaçlar)"),
    ];
  }
}
