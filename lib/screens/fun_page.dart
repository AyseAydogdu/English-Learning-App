import 'package:flutter/material.dart';
import 'package:language_learning_app/screens/story_page.dart';

class FunPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FunPageState();
  }
}

class FunPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eğlence"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 5),
          // header,
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 50,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueGrey[400],
                    ),
                    child: Text(
                      "Müzik",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, "/proverb"),
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey[400],
                      ),
                      child: Text(
                        "Ata Sözleri",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, "/rigmarole"),
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey[400],
                      ),
                      child: Text(
                        "Tekerlemeler",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoryPage(0),
                          ));
                    },
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey[400],
                      ),
                      child: Text(
                        "Hikayeler",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
