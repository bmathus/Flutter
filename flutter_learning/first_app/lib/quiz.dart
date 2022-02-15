import 'package:flutter/material.dart';
import './answer.dart';
import './question.dart';

class Quiz extends StatelessWidget {
  final questions;
  final int questionIndex;
  final Function switchQuestion;

  Quiz(
      {@required this.questions,
      @required this.questionIndex,
      @required this.switchQuestion});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[questionIndex]["question"]),
        Answer(
            () => switchQuestion(
                (questions[questionIndex]["answers"] as List)[0]["score"]),
            (questions[questionIndex]["answers"] as List)[0]["text"]),
        Answer(
            () => switchQuestion(
                (questions[questionIndex]["answers"] as List)[1]["score"]),
            (questions[questionIndex]["answers"] as List)[1]["text"]),
        Answer(
            () => switchQuestion(
                (questions[questionIndex]["answers"] as List)[2]["score"]),
            (questions[questionIndex]["answers"] as List)[2]["text"]),
      ],
    );
  }
}
