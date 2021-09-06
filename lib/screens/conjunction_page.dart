import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:language_learning_app/api/users_api.dart';
import 'package:language_learning_app/models/dictionary.dart';
import 'package:language_learning_app/provider/auth_manager.dart';
import 'package:language_learning_app/provider/dictionary_manager.dart';
import 'package:language_learning_app/provider/yds_manager.dart';
import 'package:language_learning_app/screens/select_conjunction_page.dart';
import 'package:provider/provider.dart';

class ConjunctionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConjunctionPageState();
  }
}

class ConjunctionPageState extends State {
  List<Dictionarys> _dcList = [];
  Dictionarys dictionary;
  String language = "en";
  User user;
  Future getPost(User user) async {
    //var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('baglaclar')
        .doc()
        .collection("baglac")
        .get();
    return qn.docs;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('baglaclar');
    final YdsManager ydsManager =
        Provider.of<YdsManager>(context, listen: false);

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
                String baglacName = document.data()['tür'];
                String id = document.data()['id'];
                return ListTile(
                    title: InkWell(
                  onTap: () {
                    ydsManager.setCurrentBaglac(id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectConjunctionPage()));
                  },
                  child: Container(
                      padding: EdgeInsets.only(top: 20, left: 10),
                      margin: EdgeInsets.all(15),
                      width: 300,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.indigo[200],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(blurRadius: 5.0, color: Colors.black12),
                          ]),
                      child: Text(baglacName)),
                )

                    //    subtitle: new Text(document.data()['company']),
                    );
              }).toList(),
            );
          },
        ));
  }
}
