import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/models/gramer.dart';
import 'package:language_learning_app/provider/gramer_manager.dart';
import 'package:provider/provider.dart';

class AdverbsOfTimeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('gramer');
    final GramerManager gramerManager =
        Provider.of<GramerManager>(context, listen: false);
    String gramerName = gramerManager.getCurrentGramer();
    return Scaffold(
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
                return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.37,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigo[200],
                    ),
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: data['adverbsOfTime'].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 50,
                            //color: Colors.amber[colorCodes[index]],
                            child: Center(
                                child: Text(data['adverbsOfTime'][index])),
                          );
                        }));

                //  Text(data['adverbsOfTime'][0])));
              }
            }));
  }
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

  //  Text(data['adverbsOfTime'][0]);
}
