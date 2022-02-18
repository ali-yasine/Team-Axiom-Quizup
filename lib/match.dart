import 'package:flutter/cupertino.dart';
import 'package:quizup_prototype_1/question.dart';
import 'package:quizup_prototype_1/player.dart';

class quiz extends StatefulWidget {
  final List<Question> questions;
  final Player player;
  int currentQuestion = 0;
  int score = 0;
  quiz({required this.questions, required this.player});
  @override
  _quizState createState() => _quizState();
}

class _quizState extends State<quiz> {
  void update() {
    setState(() {
      if ((widget.questions.elementAt(widget.currentQuestion)).hasFinished) {
        widget.currentQuestion++;
        if (widget.questions.elementAt(widget.currentQuestion).increaseScore) {
          widget.score++;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.questions.elementAt(widget.currentQuestion);
  }
}
