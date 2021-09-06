import 'package:flutter/material.dart';
import 'package:language_learning_app/api/artist_api.dart';
import 'package:language_learning_app/models/artists.dart';
import 'package:language_learning_app/provider/artist_manager.dart';
import 'package:language_learning_app/screens/music_player_page.dart';
import 'package:provider/provider.dart';

class MusicsPage extends StatefulWidget {
  @override
  MusicsPageState createState() => MusicsPageState();
}

class MusicsPageState extends State<MusicsPage> {
  //List<Artists> artistList;

  @override
  void initState() {
    // artistList = Artists.ArtistList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ArtistManager artistManager = Provider.of<ArtistManager>(context);
    Artists artist = artistManager.artist;
    // ArtistApi  setMusicByArtistId(artist.id);
    //

    List<Music> musicList = ArtistApi.getMusicByArtistId(artist.id);

    return Scaffold(
      appBar: AppBar(
        title: Text("Şarkılar"),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height,
        width: 500,
        child: IntrinsicHeight(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: musicList.length,
              itemBuilder: (BuildContext context, int index) {
                Music music = musicList[index];
                return InkWell(
                  onTap: () {
                    artistManager.setCurrentMusic(music);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MusicPlayerPage(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 300,
                            height: 60,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.blue[200], Colors.green[300]],
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5.0, color: Colors.black12),
                                ]),
                            child: Center(
                              child: Text(
                                musicList[index].musicName,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic, fontSize: 25),
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
