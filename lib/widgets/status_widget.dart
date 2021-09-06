import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/models/gramer.dart';
import 'package:language_learning_app/provider/gramer_manager.dart';
import 'package:provider/provider.dart';

class StatusWidget extends StatelessWidget {
  String name2;
  StatusWidget(this.name2);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('gramer');
    final GramerManager gramerManager =
        Provider.of<GramerManager>(context, listen: false);
    String gramerName = gramerManager.getCurrentGramer();
    return Scaffold(
        appBar: AppBar(
          title: Text("Cümleler"),
        ),
        body: FutureBuilder<DocumentSnapshot>(
            future: users.doc(gramerName).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data();
                var data2 = Gramer.fromMap(data);
                return ListView(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Center(
                            child: Text(
                          "Olumlu Cümleler",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontStyle: FontStyle.italic),
                        ))),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              tileMode: TileMode.mirror,
                              colors: [Colors.purple[100], Colors.indigo[200]],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(blurRadius: 5.0, color: Colors.black12),
                            ]),
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: data['positive'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 50,
                                //color: Colors.amber[colorCodes[index]],
                                child: Center(
                                    child: Text(data['positive'][index])),
                              );
                            })),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "Olumsuz Cümleler",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              tileMode: TileMode.mirror,
                              colors: [Colors.purple[100], Colors.indigo[200]],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(blurRadius: 5.0, color: Colors.black12),
                            ]),
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: data['negative'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 50,
                                //color: Colors.amber[colorCodes[index]],
                                child: Center(
                                    child: Text(data['negative'][index])),
                              );
                            })),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "Soru Cümleleri",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              tileMode: TileMode.mirror,
                              colors: [Colors.purple[100], Colors.indigo[200]],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(blurRadius: 5.0, color: Colors.black12),
                            ]),
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: data['question'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 50,
                                //color: Colors.amber[colorCodes[index]],
                                child: Center(
                                    child: Text(data['question'][index])),
                              );
                            })),
                  ],
                );

                //  Text(data['adverbsOfTime'][0])));
              }
            }));
  }
}
