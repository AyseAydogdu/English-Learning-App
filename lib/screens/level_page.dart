import 'package:flutter/material.dart';
import 'package:language_learning_app/models/levels.dart';
import 'package:language_learning_app/screens/basic_user_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LevelPageState();
  }
}

class LevelPageState extends State<LevelPage> {
  String level;
  SharedPreferences levelData;
  bool newlevelstatus;
  String newlevel;
  Levels levl;
  List<Levels> levels;

  @override
  void initState() {
    super.initState();
    // checkLevels();
    levels = Levels.LanguageList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seviye Seçimi"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: 500,
        child: IntrinsicHeight(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: levels.length,
              itemBuilder: (BuildContext context, int index) {
                String name = levels[index].name;
                //  levelData.setString("level", name);
                // levelData.setBool("durum", false);
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/$name");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 150,
                          width: 200,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(levels[index].imageUrl),
                          ),
                        ),
                        //   Text(levels[index].name),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  void checkLevels() async {
    levelData = await SharedPreferences.getInstance();
    newlevelstatus = (levelData.getBool('durum') ?? true);
    newlevel = levelData.getString("level");
    if (newlevelstatus == false) {
      Navigator.pushNamed(context, "/newlevel");
    }
  }
}
