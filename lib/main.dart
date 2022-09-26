import 'package:flutter/material.dart';

import 'FirstRoute.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Basics',
      home: FirstRoute(),
    ),
  );
}
