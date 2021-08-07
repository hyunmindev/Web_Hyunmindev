import 'package:flutter/material.dart';

class MyTheme with ChangeNotifier {
  bool _isDarkTheme = false;

  ThemeData get theme {
    if (_isDarkTheme) {
      return ThemeData.dark();
    } else {
      return ThemeData.light();
    }
  }

  void setIsDarkTheme(value) {
    _isDarkTheme = value;
    notifyListeners();
  }
}
