import 'package:flutter/material.dart';

class MainTheme with ChangeNotifier {
  bool _isDarkTheme = false;

  ThemeData get theme {
    if (_isDarkTheme) {
      return ThemeData(
        fontFamily: 'Dosis',
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: 'Dosis',
            fontWeight: FontWeight.w700,
            fontSize: 48,
          ),
        ),
        brightness: Brightness.dark,
        highlightColor: Color(0xffE7D2CC),
      );
    } else {
      return ThemeData(
        fontFamily: 'Dosis',
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: 'Dosis',
            fontWeight: FontWeight.w700,
            fontSize: 48,
          ),
        ),
        highlightColor: Color(0xffb68b7e),
        scaffoldBackgroundColor: Color(0xffEEEDE7),
        accentColor: Color(0xffB9B7BD),
        primaryColor: Color(0xff868B8E),
        brightness: Brightness.light,
      );
    }
  }

  void setIsDarkTheme(value) {
    _isDarkTheme = value;
    notifyListeners();
  }
}
