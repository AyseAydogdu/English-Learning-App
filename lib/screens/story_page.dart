import 'package:flutter/material.dart';
import 'package:language_learning_app/api/funapi.dart';
import 'package:language_learning_app/models/story.dart';
import 'package:language_learning_app/provider/fundata.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class StoryPage extends StatefulWidget {
  int index;
  StoryPage(this.index);
  @override
  State<StatefulWidget> createState() {
    return StoryPageState(index);
  }
}

class StoryPageState extends State {
  int index;
  StoryPageState(this.index);
  List<Story> stories = [];
  Story story;

  @override
  void initState() {
    final FunData funProvider = Provider.of<FunData>(context, listen: false);
    FunApi.getStories(funProvider);
    //List<Categories> categories = cartProvider.getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FunData funProvider = Provider.of<FunData>(context);

    // CategoryApi.getCategoriesKolay(cartProvider);
    story = funProvider.storyList[index];
    return Scaffold(
      appBar: AppBar(
        title: Text("Hikayeler"),
      ),
      body: funProvider != null
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.orange[200],
                          //decoration: BoxDecoration(
                          //    borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              Text(story.heading,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red)),
                              Text(
                                story.story,
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            color: Colors.brown[200],
                            child: Text(story.meaning,
                                style: TextStyle(fontSize: 15))),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
                //scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                // itemCount: funProvider.storyList.length,
                // funProvider.proverbsList.length,
                // itemBuilder: (BuildContext context, index) {
              ))
          : Center(
              child: CircularProgressIndicator(),
            ),
      persistentFooterButtons: <Widget>[
        new RaisedButton(
          child: Text("İlerle"),
          onPressed: () {
            index = index + 1;
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoryPage(index),
                ));
          },
        ),
      ],
    );
  }
}
