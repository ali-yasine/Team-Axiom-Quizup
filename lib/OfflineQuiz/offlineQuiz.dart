import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Screens/ResultsScreen.dart';
import '../Quiz components/question.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import 'package:quizup_prototype_1/Utilities/question_template.dart';

import 'offlineQuestion.dart';

class OfflineQuiz extends StatefulWidget {
  final Player player;
  final Player opponent;
  final String gameID;
  final List<QuestionTemplate> questionTemplates;
  final String subject;
  final int playerNum;

  const OfflineQuiz(
      {Key? key,
      required this.opponent,
      required this.questionTemplates,
      required this.player,
      required this.gameID,
      required this.playerNum,
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
  late final List<OfflineQuestion> questions;

  int correct = 0;
  int incorrect = 0;
  late final int opponentScore;
  late String playerNum;
  late String opponentNum;
  void initializeQuestions() {
    questions = widget.questionTemplates
        .map(
          (temp) => OfflineQuestion(
            opponent: widget.opponent,
            questionNum: currentQuestion,
            currentScore: score,
            opponentScore: opponentScore,
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
    setState(() {
      opponentScore = currQuestion.opponentScore;
      score = currQuestion.currentScore;
      ++currentQuestion;
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
      return Results(
        player: widget.player,
        score: score,
        subject: widget.subject,
        correct: correct,
        incorrect: incorrect,
        opponentScore: opponentScore,
      );
    }
  }
}
