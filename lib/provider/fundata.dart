import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:language_learning_app/models/proverbs.dart';
import 'package:language_learning_app/models/rigmarole.dart';
import 'package:language_learning_app/models/story.dart';

class FunData extends ChangeNotifier {
  List<Proverbs> _proverbList = [];
  List<Rigmaroles> _rigmaroleList = [];
  List<Story> _storyList = [];

  set proverbsList(List<Proverbs> list) {
    _proverbList = list;
    notifyListeners();
  }

  set storyList(List<Story> list) {
    _storyList = list;
    notifyListeners();
  }

  set rigmarolesList(List<Rigmaroles> list) {
    _rigmaroleList = list;
    notifyListeners();
  }

  UnmodifiableListView<Proverbs> get proverbsList =>
      UnmodifiableListView(_proverbList);
  UnmodifiableListView<Rigmaroles> get rigmarolesList =>
      UnmodifiableListView(_rigmaroleList);
  UnmodifiableListView<Story> get storyList => UnmodifiableListView(_storyList);
}
