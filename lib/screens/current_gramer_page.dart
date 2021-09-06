import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/models/gramer.dart';
import 'package:language_learning_app/provider/gramer_manager.dart';
import 'package:language_learning_app/screens/gramer_next_page.dart';
import 'package:language_learning_app/widgets/place_of_use_widget.dart';
import 'package:provider/provider.dart';

class CurrentGramerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CurrentGramerPageState();
  }
}

class CurrentGramerPageState extends State<CurrentGramerPage> {
  /* Future getPost() async {
    //var firestore = FirebaseFirestore.instance;
    var qn = await FirebaseFirestore.instance.collection('gramer').doc().get();
    return qn;
  }*/

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('gramer');
    final GramerManager gramerManager =
        Provider.of<GramerManager>(context, listen: false);
    String gramerName = gramerManager.getCurrentGramer();
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Text(
              gramerName,
              style: TextStyle(color: Colors.green, fontSize: 25),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Kullanım Yerleri",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontStyle: FontStyle.italic),
          ),
          Container(height: 500, child: PlaceOfUseWidget()),

          //    Container(height: 400, child: AllProducts()),
        ],
      ),
      persistentFooterButtons: <Widget>[
        new RaisedButton(
          child: Text("Devam Et"),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GramerNextPage(),
                ));
          },
        ),
      ],
    );
  }
}
