import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/answer.dart';
import 'package:quizup_prototype_1/player.dart';
import 'package:quizup_prototype_1/timer.dart';

class Question extends StatefulWidget {
  final String prompt;
  final List<String> wrongAnswersTxt;
  final String correctAnswerTxt;
  final String subject;
  final Player player;
  late int currentScore;
  final VoidCallback onFinish;

  // ignore: prefer_const_constructors_in_immutables
  Question(
      {Key? key,
      required this.prompt,
      required this.wrongAnswersTxt,
      required this.correctAnswerTxt,
      required this.subject,
      required this.player,
      required this.currentScore,
      required this.onFinish})
      : super(key: key);
  late bool increaseScore;
  late int timeTaken;

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> with TickerProviderStateMixin {
  static const int time = 10; //Time for each question
  late Timer timer;

  void animationHandler() async {
    timer.stop();
    Future.delayed(Duration(milliseconds: 300))
        .then((value) => {widget.timeTaken = timer.timeTaken});
  }

  void done(bool incScore) {
    setState(() {
      widget.increaseScore = incScore;
      if (incScore) {
        widget.currentScore += 10 - (widget.timeTaken);
      }
    });
  }

  void beginTimer() {
    timer = Timer(
      alignment: Alignment.centerLeft,
      time: time,
      onFinish: () => {widget.increaseScore = false, widget.onFinish()},
    );
  }

  List<Answer> makeAnswers() {
    late final Answer correctAnswer = Answer(
        ans: widget.correctAnswerTxt,
        handleAnimation: () => animationHandler(),
        colorOnPress: Colors.green,
        ontap: () => {done(true), widget.onFinish()});
    late final List<Answer> wrongAnswers = widget.wrongAnswersTxt
        .map((e) => Answer(
              ans: e,
              colorOnPress: Colors.red,
              handleAnimation: () => animationHandler(),
              ontap: () => {done(false), widget.onFinish()},
            ))
        .toList();
    late List<Answer> answers = [
      correctAnswer,
      wrongAnswers.first,
      wrongAnswers.elementAt(1),
      wrongAnswers.last
    ];
    answers.shuffle();
    return answers;
  }

  @override
  Widget build(BuildContext context) {
    beginTimer();
    var answers = makeAnswers();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.subject,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        titleTextStyle: const TextStyle(fontStyle: FontStyle.italic),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 52, 80, 92),
      ),
      body: Column(children: [
        Flexible(
          child: Text(
              widget.player.username + " :" + widget.currentScore.toString(),
              style:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          flex: 1,
        ),
        Flexible(
          child: Row(children: [
            Flexible(
              child: Container(child: timer, margin: const EdgeInsets.all(10)),
              flex: 2,
            ),
            Flexible(
                child: Column(children: [
              SizedBox(
                  child: Text(
                widget.prompt,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
              answers.first,
              const SizedBox(height: 20),
              answers.elementAt(1),
              const SizedBox(height: 20),
              answers.elementAt(2),
              const SizedBox(height: 20),
              answers.last,
            ])),
            const Flexible(flex: 2, child: SizedBox()),
          ]),
          flex: 7,
        )
      ]),
    );
  }
}
