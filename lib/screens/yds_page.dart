import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/api/yds_api.dart';
import 'package:language_learning_app/models/phrasalVerb.dart';
import 'package:language_learning_app/models/yds.dart';
import 'package:language_learning_app/provider/gramer_manager.dart';
import 'package:language_learning_app/screens/current_gramer_page.dart';
import 'package:provider/provider.dart';

class YdsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return YdsPageState();
  }
}

class YdsPageState extends State<YdsPage> {
  List<Yds> ydsList;

  @override
  void initState() {
    ydsList = Yds.getYds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Konular"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: 500,
        child: IntrinsicHeight(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: ydsList.length,
              itemBuilder: (BuildContext context, int index) {
                String name = ydsList[index].name;
                String i = index.toString();
                //  levelData.setString("level", name);
                // levelData.setBool("durum", false);
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/$i");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                tileMode: TileMode.mirror,
                                colors: [
                                  Colors.blue[200],
                                  Colors.deepPurple[200]
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5.0, color: Colors.black12),
                              ]),
                          height:
                              80, //MediaQuery.of(context).size.height * 0.18,
                          width: MediaQuery.of(context).size.width * 0.95,

                          child: Center(
                            child: Text(
                              ydsList[index].name,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
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
