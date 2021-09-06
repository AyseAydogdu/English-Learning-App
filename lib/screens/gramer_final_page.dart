import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/api/gramer_api.dart';
import 'package:language_learning_app/provider/gramer_manager.dart';
import 'package:language_learning_app/widgets/status_widget.dart';
import 'package:provider/provider.dart';

class GramerFinalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GramerFinalPageState();
  }
}

class GramerFinalPageState extends State<GramerFinalPage> {
  /* Future getPost() async {
    //var firestore = FirebaseFirestore.instance;
    var qn = await FirebaseFirestore.instance.collection('gramer').doc().get();
    return qn;
  }*/
  String negative = "negative";
  String positive = "positive";
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
      body: ListView(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              child: StatusWidget(positive)),
        ],
      ),
    );
  }
}
