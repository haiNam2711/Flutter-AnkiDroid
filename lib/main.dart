import 'package:flutter/material.dart';

import 'first_route.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Basics',
      home: FirstRoute(),
    ),
  );
}
