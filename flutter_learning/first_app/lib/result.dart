import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final Function reserQuiz;

  Result(this.totalScore, this.reserQuiz);

  String get getResultText {
    String resultText;
    if (totalScore <= 8) {
      resultText = "Ok";
    } else if (totalScore <= 16) {
      resultText = "Nice";
    } else if (totalScore <= 28) {
      resultText = "Very Nice!";
    } else {
      resultText = "You dit it!";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            getResultText,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          RaisedButton(
            onPressed: reserQuiz,
            textColor: Colors.black,
            child: Text("Reset quiz"),
          )
        ],
      ),
    );
  }
}
