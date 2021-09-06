import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:language_learning_app/models/dictionary.dart';

class DictionaryManager extends ChangeNotifier {
  List<Dictionarys> _dictionaryList = [];
  String st;
  setdictionaryList(List<Dictionarys> list) {
    _dictionaryList = list;
    notifyListeners();
  }

  UnmodifiableListView<Dictionarys> get dictionaryList =>
      UnmodifiableListView(_dictionaryList);
}
