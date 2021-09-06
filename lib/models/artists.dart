class Artists {
  String id;
  String name;
  String imageUrl;

  List<Music> music;
  Artists(this.id, this.name, this.imageUrl);

  static List<Artists> artistList = [
    Artists("1", "Adele", "images/adele.jpg"),
    Artists("2", "Anne Marie", "images/annemarie.jpg"),
    Artists("3", "Dua Lipa", "images/dualipa.jpg")
  ];
}

class Music {
  String artistId;
  String musicName;
  String id;

  Music(this.artistId, this.musicName, this.id);
  static List<Music> musicList = [
    Music("1", "Millions Years Ego", "q9AbxEVFxz4"),
    Music("2", "BirthDay", "YTMUVu2rWhc"),
    Music("3", "Break My Heart", "MlVSBosFHGY"),
    Music("1", "Send My Love", "bngKrkQzWRM"),
    Music("2", "Friends", "Db2naA8m4Rw"),
    Music("3", "Physical", "-2zad8fY-Oc"),
  ];
}
