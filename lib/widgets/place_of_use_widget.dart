import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/models/gramer.dart';
import 'package:language_learning_app/provider/gramer_manager.dart';
import 'package:provider/provider.dart';

class PlaceOfUseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('gramer');
    final GramerManager gramerManager =
        Provider.of<GramerManager>(context, listen: false);
    String gramerName = gramerManager.getCurrentGramer();
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(gramerName).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            var data2 = Gramer.fromMap(data);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: data2.adverbsOfTime.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(8),
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                tileMode: TileMode.mirror,
                                colors: [
                                  Colors.purple[100],
                                  Colors.indigo[200]
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5.0, color: Colors.black12),
                              ]),
                          child: Center(
                              child: Text(
                            data['placeOfUse'][index],
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ))),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  );
                },
              ),

              /* Column(
                      children: [
                        // Text(data['name']),
                        SizedBox(
                          height: 10,
                        ),
                        //  Text(data['auxiliaryVerb']),
                        SizedBox(
                          height: 20,
                        ),

                        
                      ],
                    ),*/
            );
            //  Text(data['adverbsOfTime'][0]);
          }

          return Text("loading");
        },
      ),
    );
  }
}
