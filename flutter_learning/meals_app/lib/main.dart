import 'package:flutter/material.dart';

import './categories_screen.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DeliMeals",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CateforiesScreen(), // by mala byť vždy homepage aplikacie
    );
  }
}
