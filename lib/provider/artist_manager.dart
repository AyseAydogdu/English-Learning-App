import 'package:flutter/material.dart';
import 'package:language_learning_app/models/artists.dart';

class ArtistManager extends ChangeNotifier {
  List<Artists> _artistList = Artists.artistList;
  List<Music> _musicList = Music.musicList;

  Artists _artist;
  Music _music;

  get artisList {
    return _artistList;
  }

  get artist {
    return _artist;
  }

  get music {
    return _music;
  }

  get musicList {
    return _musicList;
  }

  void setCurrentArtist(Artists artist) {
    _artist = artist;
    notifyListeners();
  }

  void setCurrentMusic(Music music) {
    _music = music;
    notifyListeners();
  }
}
