import 'package:flutter/material.dart';

class MyTheme {
  static final darkTheme = ThemeData(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
  );
  static final lightTheme = ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
  );
}
