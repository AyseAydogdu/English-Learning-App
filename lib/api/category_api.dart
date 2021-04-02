import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_learning_app/models/categories.dart';
import 'package:language_learning_app/models/subjects.dart';
import 'package:language_learning_app/provider/data.dart';

class CategoryApi {
  static getCategoriesKolay(Data data) async {
    List<Categories> _categoryList = [];

    await FirebaseFirestore.instance
        .collection('kolay')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                Categories food = Categories.fromMap(doc.data());
                _categoryList.add(food);
              })
            });
    // return _categoryList;
    data.categoryList = _categoryList;
    //data.setCategories(_categoryList);
  }

  static getCategoriesOrta(Data data) async {
    List<Categories> _categoryList = [];

    await FirebaseFirestore.instance
        .collection('orta')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                Categories food = Categories.fromMap(doc.data());
                _categoryList.add(food);
              })
            });
    data.categoryList = _categoryList;
  }

  static getCategoriesIleri(Data data) async {
    List<Categories> _categoryList = [];

    await FirebaseFirestore.instance
        .collection('ileri')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                Categories food = Categories.fromMap(doc.data());
                _categoryList.add(food);
              })
            });
    //data.setCategories(_categoryList);
    data.categoryList = _categoryList;
  }

  static getSubjects(Data data, String name) async {
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
  }
}
