import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PhrasalVerbPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PhrasalVerbPageState();
  }
}

class PhrasalVerbPageState extends State<PhrasalVerbPage> {
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
    CollectionReference users =
        FirebaseFirestore.instance.collection('phrasalVerb');
    // List<PhrasalVerb> list1 = YdsApi().getPhrasalVerb();

    return Scaffold(
        appBar: AppBar(
          title: Text("Phrasal Verbs"),
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
                return Container(
                    child: Row(
                  children: [
                    Container(
                        height: 60,
                        width: 165,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        color: Colors.orange[200],
                        child: Center(child: Text(gramerName))),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        height: 60,
                        width: 165,
                        color: Colors.purple[200],
                        child: Center(child: Text(document.data()['mean']))),
                  ],
                ));

                //    subtitle: new Text(document.data()['company']),
              }).toList(),
            );
          },
        ));
  }
}
