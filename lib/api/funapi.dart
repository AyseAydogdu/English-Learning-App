import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_learning_app/models/proverbs.dart';
import 'package:language_learning_app/models/rigmarole.dart';
import 'package:language_learning_app/models/story.dart';
import 'package:language_learning_app/provider/fundata.dart';

class FunApi {
  static getProverbs(FunData data) async {
    List<Proverbs> _proverbsList = [];

    await FirebaseFirestore.instance
        .collection('atasözleri')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                Proverbs proverb = Proverbs.fromMap(doc.data());
                _proverbsList.add(proverb);
              })
            });
    // return _categoryList;
    data.proverbsList = _proverbsList;
    //data.setCategories(_categoryList);
  }

  static getRigmarole(FunData data) async {
    List<Rigmaroles> _rigmaroleList = [];

    await FirebaseFirestore.instance
        .collection('tekerlemeler')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                Rigmaroles rigmarole = Rigmaroles.fromMap(doc.data());
                _rigmaroleList.add(rigmarole);
              })
            });
    data.rigmarolesList = _rigmaroleList;
  }

  static getStories(FunData data) async {
    List<Story> _storyList = [];

    await FirebaseFirestore.instance
        .collection('hikayeler')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                Story story = Story.fromMap(doc.data());
                _storyList.add(story);
              })
            });
    data.storyList = _storyList;
  }
}
