import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:language_learning_app/models/phrasalVerb.dart';

class YdsApi {
  getPhrasalVerb() async {
    List<PhrasalVerb> _phrasalverbList;
    FirebaseFirestore.instance
        .collection('phrasalVerb')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                PhrasalVerb ph = PhrasalVerb.fromMap(doc.data());
                _phrasalverbList.add(ph);
              })
            });
    return _phrasalverbList;

    //data.setCategories(_categoryList);
  }

  /* static getSubjects(Data data, String name) async {
    Subjects _subjectsList;

    await FirebaseFirestore.instance
        .collection('kolay')
        .doc("$name")
        .collection("icerik")
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                Subjects food = Subjects.fromMap(doc.data());
                _subjectsList = food;
                //  _subjectsList.add(food);
              })
            });
    data.setSubjects(_subjectsList);
  }*/
}
