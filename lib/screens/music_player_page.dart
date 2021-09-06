import 'package:flutter/material.dart';
import 'package:language_learning_app/models/artists.dart';
import 'package:language_learning_app/provider/artist_manager.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MusicPlayerPage extends StatefulWidget {
  @override
  MusicPlayerPageState createState() => MusicPlayerPageState();
}

class MusicPlayerPageState extends State<MusicPlayerPage> {
  YoutubePlayerController _controller;
  static String mid;
  Music music;
  @override
  void initState() {
    ArtistManager artistManager =
        Provider.of<ArtistManager>(context, listen: false);
    music = artistManager.music;
    mid = music.id;
    // artistList = Artists.ArtistList;
    _controller = YoutubePlayerController(
        initialVideoId: mid,
        // id youtube video
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(mid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[900],
        title: Text(""),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              width: 200,
              child: Center(
                child: Text(
                  '',
                  style: TextStyle(fontSize: 18, color: Colors.amber),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }

  _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: true, //sadece butonlara basınca ekrandan çıkıyor
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          backgroundColor: Colors.greenAccent,
          title: Text(
            "Flutter serisi",
            textAlign: TextAlign.center,
          ),
          //content: Text("Hello world"),

          actions: <Widget>[
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
            )
          ],
        );
      },
    );
  }
}
