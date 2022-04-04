import 'package:flutter/cupertino.dart';
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
  late Timer opponentTimer;
  void animationHandler() {
    timer.stop();
    opponentTimer.stop();
  }

  void done(bool incScore) {
    setState(() {
      widget.increaseScore = incScore;
      widget.timeTaken = timer.timeTaken;
      if (incScore) {
        widget.currentScore += 10 - (timer.timeTaken);
      }
    });
  }

  void beginTimer() {
    timer = Timer(
      alignment: Alignment.centerLeft,
      time: time,
      onFinish: () => {done(false), widget.onFinish()},
    );
    opponentTimer = Timer(
      alignment: Alignment.centerRight,
      time: time,
      onFinish: () => {},
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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(207, 232, 255, 20),
      body: Column(children: [
        const SizedBox(height: 50),
        Text(widget.subject,
            style: const TextStyle(
                fontSize: 35,
                color: Color.fromRGBO(51, 156, 254, 10),
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 100),
        Row(
            mainAxisAlignment:
                MainAxisAlignment.center, //Center Column contents vertically,
            crossAxisAlignment: CrossAxisAlignment
                .center, //Center Column contents horizontally,

            children: [
              Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.only(left: 5, right: 10),
                child: const CircleAvatar(
                  child: CircleAvatar(
                    radius: 33,
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                ),
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Text(
                        " " +
                            widget.player.username +
                            " :" +
                            widget.currentScore.toString() +
                            " ",
                        style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(51, 156, 254, 10))),
                  )),
              Container(
                child: const Text("vs",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(51, 156, 254, 10),
                        fontWeight: FontWeight.bold)),
                margin: const EdgeInsets.only(left: 35.0, right: 35.0),
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Text(
                        " " +
                            widget.player.username +
                            " :" +
                            widget.currentScore.toString() +
                            " ",
                        style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(51, 156, 254, 10))),
                  )),
              Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.only(left: 5),
                child: const CircleAvatar(
                  child: CircleAvatar(
                    radius: 33,
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                ),
              ),
            ]),
        const SizedBox(
          height: 10,
        ),
        Flexible(
          child: Row(children: [
            Flexible(
              child: Container(child: timer, margin: const EdgeInsets.all(10)),
              flex: 2,
            ),
            Flexible(
                flex: 10,
                child: Column(children: [
                  Container(
                      width: 1000,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Color.fromRGBO(51, 156, 254, 10),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: ClipRRect(
                          //used to make circular borders
                          borderRadius: BorderRadius.circular(15),
                          child: Center(
                              child: Text(
                            widget.prompt,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(40, 156, 254, 50)),
                            textAlign: TextAlign.center,
                          )))),
                  const SizedBox(height: 60),
                  answers.first,
                  const SizedBox(height: 20),
                  answers.elementAt(1),
                  const SizedBox(height: 20),
                  answers.elementAt(2),
                  const SizedBox(height: 20),
                  answers.last,
                ])),
            Flexible(
              child: Container(
                  child: opponentTimer, margin: const EdgeInsets.all(10)),
              flex: 2,
            ),
          ]),
          flex: 7,
        )
      ]),
    );
  }
}
