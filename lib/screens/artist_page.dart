import 'package:flutter/material.dart';
import 'package:language_learning_app/models/artists.dart';
import 'package:language_learning_app/provider/artist_manager.dart';
import 'package:language_learning_app/screens/musics_page.dart';
import 'package:provider/provider.dart';

class ArtistPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ArtistPageState();
  }
}

class ArtistPageState extends State<ArtistPage> {
  List<Artists> artistList;

  @override
  void initState() {
    artistList = Artists.artistList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ArtistManager artistManager = Provider.of<ArtistManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sanatçılar"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: 500,
        child: IntrinsicHeight(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: artistList.length,
              itemBuilder: (BuildContext context, int index) {
                Artists artist = artistList[index];
                //  levelData.setString("level", name);
                // levelData.setBool("durum", false);
                return InkWell(
                  onTap: () {
                    artistManager.setCurrentArtist(artist);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MusicsPage(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height:
                              100, //MediaQuery.of(context).size.height * 0.18,
                          width:
                              100, // MediaQuery.of(context).size.width * 0.25,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage(artistList[index].imageUrl),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          artistList[index].name,
                          style: TextStyle(fontSize: 20),
                        ),
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
