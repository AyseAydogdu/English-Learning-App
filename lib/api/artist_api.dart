import 'package:language_learning_app/models/artists.dart';

class ArtistApi {
  static getMusicByArtistId(String id) {
    List<Music> _musicList = Music.musicList;
    List<Music> _musics = [];
    for (int i = 0; i < _musicList.length; i++) {
      if (_musicList[i].artistId == id) {
        // Music   music = Music(
        //      _musicList[i].artistId, _musicList[i].musicName, _musicList[i].id);
        _musics.add(_musicList[i]);
      }
    }
    return _musics;
    //  notifyListeners();
  }
}
