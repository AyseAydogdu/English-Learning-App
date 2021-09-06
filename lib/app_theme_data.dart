import 'package:flutter/material.dart';

enum AppTheme { Dark, Light }

final appThemeData = {
  AppTheme.Dark: ThemeData(
      brightness: Brightness.dark,
      // primarySwatch: Colors.green,
      primaryColor: Colors.grey),
  AppTheme.Light: ThemeData(
    primaryColor: Colors.teal[300],
    accentColor: Colors.amber,
    buttonColor: Colors.brown[400],
    visualDensity: VisualDensity.adaptivePlatformDensity,
  )
};
