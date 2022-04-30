import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Quiz components/question.dart';

import '../Screens/Offline.dart';
import '../Screens/ResultsScreen.dart';
import '../Utilities/player.dart';
import '../Utilities/question_template.dart';
import 'offlineQuestion.dart';

class OfflineQuiz extends StatefulWidget {
  final Player player;
  final Player? opponent;
  final String gameID;
  final List<QuestionTemplate> questionTemplates;
  final String subject;
  final int playerNum;
  final int opponentScore;
  const OfflineQuiz(
      {Key? key,
      this.opponent,
      required this.questionTemplates,
      required this.player,
      required this.gameID,
      required this.playerNum,
      required this.opponentScore,
      required this.subject})
      : super(key: key);
  @override
  _OfflineQuizState createState() => _OfflineQuizState();
}

class _OfflineQuizState extends State<OfflineQuiz> {
  int timeTaken = 0;
  bool isdone = false;
  int currentQuestion = 0;
  int score = 0;
  late List<OfflineQuestion> questions;

  int correct = 0;
  int incorrect = 0;
  late int opponentScore;
  late String playerNum;
  late String opponentNum;

  void initializeQuestions() {
    questions = widget.questionTemplates
        .map(
          (temp) => OfflineQuestion(
            opponent: (widget.opponent == null) ? null : widget.opponent,
            questionNum: currentQuestion,
            currentScore: score,
            opponentScore: (widget.opponent == null) ? 0 : widget.opponentScore,
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
    var currQuestion = questions.elementAt(currentQuestion);
    if (currentQuestion + 1 == (questions.length)) {
      isdone = true;
    }
    if (currQuestion.increaseScore == true) {
      correct += 1;
    } else {
      incorrect += 1;
    }
    ++currentQuestion;

    setState(() {
      opponentScore = currQuestion.opponentScore;
      score = currQuestion.currentScore;
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeQuestions();
    var size = MediaQuery.of(context).size;
    if (!isdone) {
      return SizedBox(
        child: Container(child: questions.elementAt(currentQuestion)),
        width: size.width,
        height: size.height,
      );
    } else {
      if (widget.playerNum == 1) {
        return OfflineResults(
            player: widget.player,
            score: score,
            subject: widget.subject,
            correct: correct,
            incorrect: incorrect,
            playerNum: widget.playerNum);
      }
      return Results(
        player: widget.player,
        score: score,
        subject: widget.subject,
        correct: correct,
        isChallenge: true,
        opponent: widget.opponent!,
        incorrect: incorrect,
        opponentScore: opponentScore,
      );
    }
  }
}
