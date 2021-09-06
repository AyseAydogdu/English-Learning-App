import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:language_learning_app/models/gramer.dart';

class YdsManager with ChangeNotifier {
  Gramer _gramer;
  String _baglacName;
  List<Gramer> _gramerList;
  Gramer get gramer => _gramer;

  void setCurrentBaglac(String baglac) {
    _baglacName = baglac;
    notifyListeners();
  }

  String getCurrentBaglac() {
    return _baglacName;
  }

  set gramerList(List<Gramer> list) {
    _gramerList = list;
    notifyListeners();
  }

  UnmodifiableListView<Gramer> get gramerList =>
      UnmodifiableListView(_gramerList);
}
