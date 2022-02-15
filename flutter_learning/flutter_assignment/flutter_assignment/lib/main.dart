// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int changeVar = 0;
  String text = "something";

  String get getText {
    if (changeVar == 0) {
      return "something";
    } else {
      return "somthing else";
    }
  }

  void _changeText() {
    if (changeVar == 0) {
      setState(() {
        changeVar++;
      });
    } else {
      setState(() {
        changeVar--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Assignment app"),
          ),
          body: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(getText),
              ),
              ElevatedButton(
                onPressed: _changeText,
                child: Text("Change text"),
              )
            ],
          )),
    );
  }
}
