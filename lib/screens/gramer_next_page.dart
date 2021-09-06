import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/api/gramer_api.dart';
import 'package:language_learning_app/provider/gramer_manager.dart';
import 'package:language_learning_app/screens/gramer_final_page.dart';
import 'package:language_learning_app/widgets/adverbs_of_time_widget.dart';
import 'package:language_learning_app/widgets/auxiliary_verb_widget.dart';
import 'package:provider/provider.dart';

class GramerNextPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GramerNextPageState();
  }
}

class GramerNextPageState extends State<GramerNextPage> {
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
    //  GramerApi.getGramer(gramerManager);
    //  var gramer= gramerManager.gramerList;
    String gramerName = gramerManager.getCurrentGramer();
    GramerApi.getGramers(gramerName, gramerManager);
    var gramer = gramerManager.gramer;
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Yardımcı Fiiller",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Container(height: 200, child: AuxiliaryVerbWidget()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Zaman Zarfları",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Container(height: 500, child: AdverbsOfTimeWidget()),
        ],
      ),
      persistentFooterButtons: <Widget>[
        new RaisedButton(
          child: Text("Devam Et"),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GramerFinalPage(),
                ));
          },
        ),
      ],
    );
  }
}
