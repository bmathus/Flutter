import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  int _totalScore = 0;
  final _questions = const [
    {
      "question": "What is your favorite animal?",
      "answers": [
        {"text": "Dog", "score": 5},
        {"text": "Cat", "score": 10},
        {"text": "Elephant", "score": 15}
      ]
    },
    {
      "question": "How much do you like kuťa?",
      "answers": [
        {"text": "Litlebit", "score": 5},
        {"text": "Very much", "score": 10},
        {"text": "Alot", "score": 15}
      ]
    },
    {
      "question": "How many legs does the dog have?",
      "answers": [
        {"text": "1", "score": 1},
        {"text": "2", "score": 2},
        {"text": "5", "score": 3}
      ]
    },
  ];
  void _resetQuiz() {
    setState(() {
      _totalScore = 0;
      _questionIndex = 0;
    });
  }

  void _switchQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("My First App"),
          ),
          body: (_questionIndex < _questions.length)
              ? Quiz(
                  questions: _questions,
                  questionIndex: _questionIndex,
                  switchQuestion: _switchQuestion)
              : Result(_totalScore, _resetQuiz)),
    );
  }
}
