import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Backend%20Management/fireConnect.dart';
import 'package:quizup_prototype_1/Screens/ResultsScreen.dart';
import 'question.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import 'package:quizup_prototype_1/Utilities/question_template.dart';

class Quiz extends StatefulWidget {
  final Player player;
  late final Player opponent;
  bool isdone = false;
  final int gameID;
  final List<QuestionTemplate> questionTemplates;
  final String subject;
  final int playerNum;
  List<Question>? questions;
  int currentQuestion = 0;
  int score = 0;
  int opponentScore = 0;
  int correct = 0;
  int incorrect = 0;
  Quiz(
      {Key? key,
      required this.questionTemplates,
      required this.player,
      required this.gameID,
      required this.playerNum,
      required this.subject})
      : super(key: key);
  @override
  _quizState createState() => _quizState();
}

class _quizState extends State<Quiz> {
  int timeTaken = 0;
  late String playerNum;
  late String opponentNum;
  void initializeQuestions() {
    widget.questions = widget.questionTemplates
        .map(
          (temp) => Question(
            questionNum: widget.currentQuestion,
            currentScore: widget.score,
            playerNum: widget.playerNum,
            prompt: temp.prompt,
            wrongAnswersTxt: temp.wrongAnswersTxt,
            correctAnswerTxt: temp.correctAnswerTxt,
            subject: widget.subject,
            onFinish: update,
            player: widget.player,
            gameID: widget.gameID,
          ),
        )
        .toList();
  }

  @override
  void initState() {
    initializeQuestions();
    playerNum = "Player" + widget.playerNum.toString();
    int opponentIntNum = widget.playerNum == 1 ? 2 : 1;
    opponentNum = "Player" + opponentIntNum.toString();
    super.initState();
  }

  void update() async {
    widget.questions = widget.questionTemplates
        .map(
          (temp) => Question(
            questionNum: widget.currentQuestion,
            currentScore: widget.score,
            playerNum: widget.playerNum,
            prompt: temp.prompt,
            wrongAnswersTxt: temp.wrongAnswersTxt,
            correctAnswerTxt: temp.correctAnswerTxt,
            subject: widget.subject,
            onFinish: update,
            player: widget.player,
            gameID: widget.gameID,
          ),
        )
        .toList();
    var currQuestion = widget.questions!.elementAt(widget.currentQuestion);
    if (widget.currentQuestion + 1 == (widget.questions!.length)) {
      widget.isdone = true;
    }
    if (currQuestion.increaseScore == true) {
      widget.correct += 1;
      widget.score += 10 - (currQuestion.timeTaken);
    } else {
      widget.incorrect += 1;
    }
    if (currQuestion.opponentHasAnswered) {
      setState(() {
        widget.currentQuestion++;
      });
    }
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
      return Results(
        player: widget.player,
        score: widget.score,
        subject: widget.subject,
        correct: widget.correct,
        incorrect: widget.incorrect,
        opponentScore: 0,
      );
    }
  }
}
