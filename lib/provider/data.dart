import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/api/category_api.dart';
import 'package:language_learning_app/models/categories.dart';
import 'package:language_learning_app/models/subjects.dart';

class Data extends ChangeNotifier {
  Subjects _subjects;
  List<Categories> _categoryList = [];
  Categories _currentCategories;

  UnmodifiableListView<Categories> get categoryList =>
      UnmodifiableListView(_categoryList);

  set categoryList(List<Categories> list) {
    _categoryList = list;
    notifyListeners();
  }

  /* Stream<QuerySnapshot> loadCategories() {
    return FirebaseFirestore.instance.collection('kolay').snapshots();
  }

  List<Categories> getFromCategory(QuerySnapshot snapshot) {
    List<Categories> category;
    category = snapshot.docs.map((DocumentSnapshot doc) {
      return Categories.fromSnapshot(doc);
    }).toList();
    setCategories(category);
    return category;
  }*/

  /*Future<Restaurant> getRestaurant(String restaurantId) {
    return FirebaseFirestore.instance
        .collection('restaurants')
        .doc(restaurantId)
        .get()
        .then((DocumentSnapshot doc) => Restaurant.fromSnapshot(doc));
  }*/

  /*Future getCategoriesFromApi() async {
    List<Categories> category;
    await CategoryApi.getCategories().then((value) {
      Iterable list = json.decode(value.body);
      category = list.map((c) => Categories.fromJson(c)).toList();
    });
    setCategories(category);
  }

  Future getProductsFromApi() async {
    List<Products> product;
    await ProductApi.getProducts().then((value) {
      Iterable list = json.decode(value.body);
      product = list.map((p) => Products.fromJson(p)).toList();
    });
    setProducts(product);
  }

  Future getProductsByCategoryId(Categories category) async {
    List<Products> products;
    List<Products> prod = List<Products>();
    await ProductApi.getProducts().then((value) {
      Iterable list = json.decode(value.body);
      products = list.map((product) => Products.fromJson(product)).toList();
    });
    for (int i = 0; i < products.length; i++) {
      if (products[i].categoryId == category.id) {
        prod.add(products[i]);
      }
    }
    setProductsByCategory(prod);
  }*/

  setCurrentCategories(Categories category) {
    _currentCategories = category;
    notifyListeners();
  }

  setSubjects(Subjects value) {
    _subjects = value;
    notifyListeners();
  }

  /*setCategories(List<Categories> value) {
    _categoryList = value;
    notifyListeners();
  }*/

  getCurrentCategories() {
    return _currentCategories;
  }

  /*getCategories() {
    return _categoryList;
  }*/

  getSubjects() {
    return _subjects;
  }
}
