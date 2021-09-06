import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:language_learning_app/api/users_api.dart';
import 'package:language_learning_app/api/yds_api.dart';
import 'package:language_learning_app/models/dictionary.dart';
import 'package:language_learning_app/provider/auth_manager.dart';
import 'package:language_learning_app/provider/dictionary_manager.dart';
import 'package:language_learning_app/provider/yds_manager.dart';
import 'package:provider/provider.dart';

class SelectConjunctionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SelectConjunctionPageState();
  }
}

class SelectConjunctionPageState extends State {
  List<Dictionarys> _dcList = [];
  Dictionarys dictionary;
  String language = "en";
  User user;
  Future getPost(String baglac) async {
    //var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('baglaclar')
        .doc(baglac)
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
    final YdsManager ydsManager =
        Provider.of<YdsManager>(context, listen: false);

    final AuthManager authManager =
        Provider.of<AuthManager>(context, listen: false);
    String baglac = ydsManager.getCurrentBaglac();
    user = authManager.user;
    // getUserDictionary(user, dictionaryManager, language);
    // final DictionaryManager dictionaryManager =
    //     Provider.of<DictionaryManager>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: FutureBuilder(
            future: getPost(baglac),
            builder: (context, snapshot) {
              return GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(10),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    Expanded(
                      child: FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        speed: 1000,
                        onFlipDone: (status) {
                          print(status);
                        },
                        front: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(snapshot.data[index]["name"],
                                  style: Theme.of(context).textTheme.bodyText1),
                            ],
                          ),
                        ),
                        back: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(snapshot.data[index]["mean"],
                                  style: Theme.of(context).textTheme.bodyText1),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
