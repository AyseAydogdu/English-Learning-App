import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:language_learning_app/models/dictionary.dart';
import 'package:language_learning_app/models/users.dart';
import 'package:language_learning_app/provider/auth_manager.dart';
import 'package:language_learning_app/provider/dictionary_manager.dart';
import 'package:language_learning_app/provider/user_manager.dart';

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
        .doc(name)
        .set({"name": name, "translatedName": translatedName});
  }

  static getUserDictionary(
      User user, DictionaryManager dictionaryManager, String valueC) {
    List<Dictionarys> _dictionaryList;
    print(user.uid);
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection("dictionary$valueC")
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                Dictionarys dictionary = Dictionarys.fromMap(doc.data());
                _dictionaryList.add(dictionary);
              })
            });

    dictionaryManager.setdictionaryList(_dictionaryList);
  }

  static getUsers(User user, UserManager userManager) async {
    List<Users> userList;
    Users users;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      users = Users.fromMap(value.data());
      // print(value.data()["name"]);
    });
    userManager.setUser(users);
  }

  updateUsers(User user, UserManager userManager) async {
    var users = userManager.user;
    await FirebaseFirestore.instance.collection("users").doc(user.uid).update({
      "name": users.name,
      "surname": users.surname,
      "mail": users.mail,
      "password": users.password,
    });
  }

  /* static getUsers(User user)  {
    List<Users> _userList;

     FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                Users user = Users.fromMap(doc.data());
                _userList.add(user);
              })
            });
  }*/
}
