//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/provider/gramer_manager.dart';
import 'package:language_learning_app/screens/current_gramer_page.dart';
import 'package:provider/provider.dart';

class GramerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GramerPageState();
  }
}

class GramerPageState extends State<GramerPage> {
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

    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: users.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                String gramerName = document.data()['name'];
                return ListTile(
                    title: InkWell(
                  onTap: () {
                    gramerManager.setCurrentGramer(gramerName);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CurrentGramerPage()));
                  },
                  child: Container(
                      margin: EdgeInsets.all(10),
                      width: 300,
                      height: 80,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            tileMode: TileMode.mirror,
                            colors: [Colors.blue[200], Colors.deepPurple[200]],
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(blurRadius: 5.0, color: Colors.black12),
                          ]),
                      child: Center(child: Text(gramerName))),
                )
                    //    subtitle: new Text(document.data()['company']),
                    );
              }).toList(),
            );
          },
        ));
  }
}
