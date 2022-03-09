import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/ResultsScreen.dart';
import 'package:quizup_prototype_1/question.dart';
import 'package:quizup_prototype_1/player.dart';
import 'package:quizup_prototype_1/question_template.dart';

class Quiz extends StatefulWidget {
  final List<question_template> questionsTemplates;
  final Player player;
  bool isdone = false;
  final String subject;
  List<Question>? questions;
  int currentQuestion = 0;
  int score = 0;
  int correct=0;
  int incorrect=0;
  Quiz(
      {Key? key,
      required this.questionsTemplates,
      required this.player,
      required this.subject})
      : super(key: key);
  @override
  _quizState createState() => _quizState();
}

class _quizState extends State<Quiz> {
  int timeTaken = 0;
  @override
  void initState() {
    widget.questions = widget.questionsTemplates
        .map(
          (temp) => Question(
            prompt: temp.prompt,
            wrongAnswersTxt: temp.wrongAnswersTxt,
            correctAnswerTxt: temp.correctAnswerTxt,
            subject: widget.subject,
            onFinish: update,
            player: widget.player,
            currentScore: widget.score,
          ),
        )
        .toList();
    super.initState();
  }

  void update() async {
    var currQuestion = widget.questions!.elementAt(widget.currentQuestion);
    if (widget.currentQuestion + 1 == (widget.questions!.length)) {
      widget.isdone = true;
    }
    if (currQuestion.increaseScore == true)
    {
      widget.correct+=1;
      widget.score += 10 - (currQuestion.timeTaken);
    }
    else {
      widget.incorrect+=1;
    }
    widget.questions = widget.questionsTemplates
        .map(
          (temp) => Question(
            prompt: temp.prompt,
            wrongAnswersTxt: temp.wrongAnswersTxt,
            correctAnswerTxt: temp.correctAnswerTxt,
            subject: widget.subject,
            onFinish: update,
            player: widget.player,
            currentScore: widget.score,
          ),
        )
        .toList();
    setState(() {
      widget.currentQuestion++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (!widget.isdone) {
      return SizedBox(
        child: Container(
            child: widget.questions!.elementAt(widget.currentQuestion)),
        width: size.width,
        height: size.height,
      );
    } else {
      return results(
          player: widget.player, score: widget.score, subject: widget.subject, correct: widget.correct, incorrect:widget.incorrect,opponentScore: 100,);
    }
  }
}
