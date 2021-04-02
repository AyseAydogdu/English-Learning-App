import 'package:flutter/material.dart';
import 'package:language_learning_app/models/levels.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelManager with ChangeNotifier {
  Levels _levels;
  final _levelPreference = "theme_preference";

  LevelManager() {
    _loadLevel();
  }

  void _loadLevel() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String prefLevel = sharedPreference.getString(_levelPreference);
    _levels.name = prefLevel;
    notifyListeners();
  }

  /* ThemeData get themeData {
    if (_themeData == null) {
      _themeData = appThemeData[AppTheme.Light];
    }
    return _themeData;
  }

  setTheme(AppTheme theme) async {
    _themeData = appThemeData[theme];
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(_themePreference, AppTheme.values.indexOf(theme));
    notifyListeners();
  }*/
}
