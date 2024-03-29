import 'package:flutter/material.dart';
import '../Screens/ResultsScreen.dart';
import '../Utilities/player.dart';
import '../Utilities/question_template.dart';
import 'question.dart';

class Quiz extends StatefulWidget {
  final Player player;
  final Player opponent;
  bool isdone = false;
  final bool isChallenge;
  final String gameID;
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
      required this.opponent,
      required this.isChallenge,
      required this.questionTemplates,
      required this.player,
      required this.gameID,
      required this.playerNum,
      required this.subject})
      : super(key: key);
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int timeTaken = 0;
  late String playerNum;
  late String opponentNum;
  void initializeQuestions() {
    widget.questions = widget.questionTemplates
        .map(
          (temp) => Question(
            isChallenge: widget.isChallenge,
            opponent: widget.opponent,
            questionNum: widget.currentQuestion,
            currentScore: widget.score,
            opponentScore: widget.opponentScore,
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
    var currQuestion = widget.questions!.elementAt(widget.currentQuestion);
    if (widget.currentQuestion + 1 == (widget.questions!.length)) {
      widget.isdone = true;
    }
    if (currQuestion.increaseScore == true) {
      widget.correct += 1;
    } else {
      widget.incorrect += 1;
    }
    setState(() {
      widget.opponentScore = currQuestion.opponentScore;
      widget.score = currQuestion.currentScore;
      ++widget.currentQuestion;
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeQuestions();
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
        isChallenge: widget.isChallenge,
        opponent: widget.opponent,
        score: widget.score,
        subject: widget.subject,
        correct: widget.correct,
        incorrect: widget.incorrect,
        opponentScore: widget.opponentScore,
      );
    }
  }
}
