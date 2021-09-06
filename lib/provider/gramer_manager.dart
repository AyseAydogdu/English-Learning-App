import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:language_learning_app/models/gramer.dart';

class GramerManager with ChangeNotifier {
  Gramer _gramer;
  String _gramerName;
  List<Gramer> _gramerList;
  Gramer get gramer => _gramer;

  void setGramer(Gramer gramer) {
    _gramer = gramer;
    notifyListeners();
  }

  void setCurrentGramer(String gramer) {
    _gramerName = gramer;
    notifyListeners();
  }

  String getCurrentGramer() {
    return _gramerName;
  }

  set gramerList(List<Gramer> list) {
    _gramerList = list;
    notifyListeners();
  }

  UnmodifiableListView<Gramer> get gramerList =>
      UnmodifiableListView(_gramerList);
}
