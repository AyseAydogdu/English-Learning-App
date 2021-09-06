import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_learning_app/models/gramer.dart';
import 'package:language_learning_app/provider/gramer_manager.dart';

class GramerApi {
  static getGramers(String name, GramerManager gramerManager) async {
    List<Gramer> gramerList;
    Gramer gramer;

    await FirebaseFirestore.instance
        .collection('gramer')
        .doc(name)
        .get()
        .then((value) {
      gramer = Gramer.fromMap(value.data());

      // print(value.data()["name"]);
    });
    gramerManager.setGramer(gramer);
    // userManager.setUser(users);
  }

  static getGramer(GramerManager gramerManager) async {
    List<Gramer> _gramerList;

    await FirebaseFirestore.instance
        .collection('gramer')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                Gramer gramer = Gramer.fromMap(doc.data());
                _gramerList.add(gramer);
              })
            });
    gramerManager.gramerList = _gramerList;
  }
}
