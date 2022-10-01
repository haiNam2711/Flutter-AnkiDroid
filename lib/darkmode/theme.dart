import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  static bool darkMode = false;

  ThemeMode currentTheme() {
    return darkMode? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    darkMode = !darkMode;
    notifyListeners();
  }
}