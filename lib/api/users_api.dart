import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:language_learning_app/models/dictionary.dart';
import 'package:language_learning_app/provider/auth_manager.dart';
import 'package:language_learning_app/provider/dictionary_manager.dart';

class UsersApi {
  static signout(AuthManager authManager) async {
    await FirebaseAuth.instance
        .signOut()
        .catchError((error) => print(error.code));

    authManager.setUser(null);
  }

  static initializeCurrentUser(AuthManager authManager) async {
    User firebaseUser = await FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      print(firebaseUser);
      authManager.setUser(firebaseUser);
    }
  }

  static addUserDictionary(String valueC, String name, String translatedName,
      AuthManager authManager) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(authManager.user.uid)
        .collection("dictionary$valueC")
        .add({"name": name, "translatedName": translatedName});
  }

  static getUserDictionary(AuthManager authManager,
      DictionaryManager dictionaryManager, String valueC) async {
    List<Dictionary> _dictionaryList;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(authManager.user.uid)
        .collection("dictionary$valueC")
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                Dictionary dictionary = Dictionary.fromMap(doc.data());
                _dictionaryList.add(dictionary);
              })
            });
    dictionaryManager.dictionaryList = _dictionaryList;
  }
}
