import 'package:flutter/material.dart';
import 'package:language_learning_app/app_theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager with ChangeNotifier {
  ThemeData _themeData;
  final _themePreference = "theme_preference";
  //bool _isLight = true;
  ThemeManager() {
    _loadTheme();
  }

  void _loadTheme() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    int prefTheme = sharedPreference.getInt(_themePreference);

    if (prefTheme == null) {
      Brightness systemTheme =
          WidgetsBinding.instance.window.platformBrightness;
      prefTheme = systemTheme.index;
    }

    _themeData = appThemeData[AppTheme.values[prefTheme]];
    notifyListeners();
  }

  /*void toggleTheme() {
    _isLight = !_isLight;
  }*/

  ThemeData get themeData {
    if (_themeData == null) {
      _themeData = appThemeData[AppTheme.Light];
    }
    return _themeData;
    /* _isLight
        ? appThemeData[AppTheme.Light]
        : appThemeData[AppTheme.Dark];*/
  }

  setTheme(AppTheme theme) async {
    _themeData = appThemeData[theme];
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(_themePreference, AppTheme.values.indexOf(theme));
    notifyListeners();
  }
}
