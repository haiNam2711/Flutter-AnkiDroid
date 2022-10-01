import 'package:five_control_widget/darkmode/theme.dart';
import 'package:flutter/material.dart';
import 'darkmode/config.dart';
import 'first_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    appTheme.addListener((){
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnkiDroid',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: AppTheme().currentTheme(),
      home: const FirstRoute(),

    );
  }
}
