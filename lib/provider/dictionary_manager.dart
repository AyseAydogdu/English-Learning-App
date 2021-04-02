import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:language_learning_app/models/dictionary.dart';

class DictionaryManager extends ChangeNotifier {
  List<Dictionary> _dictionaryList = [];
  set dictionaryList(List<Dictionary> list) {
    _dictionaryList = list;
    notifyListeners();
  }

  UnmodifiableListView<Dictionary> get dictionaryList =>
      UnmodifiableListView(_dictionaryList);
}
