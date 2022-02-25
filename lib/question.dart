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
  static const int time = 10;
  @override
  initState() {
    super.initState();
  }

  void done(bool incScore, AnimationController controller) {
    setState(() {
      widget.timeTaken = controller.lastElapsedDuration!.inSeconds.toInt();
      widget.increaseScore = incScore;
      if (incScore) {
        widget.currentScore += 10 - (widget.timeTaken);
      }
      controller.dispose();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void beginTimer(AnimationController controller) async {
    controller = AnimationController(
        vsync: this, duration: const Duration(seconds: time));
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.increaseScore = false;
        widget.onFinish();
      }
    });
    Future.delayed(const Duration(seconds: 1))
        .then((value) => controller.forward(from: 0.0));
  }

  @override
  void didUpdateWidget(Question oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    AnimationController controller = AnimationController(
        vsync: this, duration: const Duration(seconds: time));
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.increaseScore = false;
        widget.onFinish();
      }
    });
    Future.delayed(const Duration(seconds: 1))
        .then((value) => controller.forward(from: 0.0));
    late final Answer correctAnswer = Answer(
        ans: widget.correctAnswerTxt,
        colorOnPress: Colors.green,
        ontap: () => {done(true, controller), widget.onFinish()});

    late final List<Answer> wrongAnswers = widget.wrongAnswersTxt
        .map((e) => Answer(
              ans: e,
              colorOnPress: Colors.red,
              ontap: () => {done(false, controller), widget.onFinish()},
            ))
        .toList();
    late List<Answer> answers = [
      correctAnswer,
      wrongAnswers.first,
      wrongAnswers.elementAt(1),
      wrongAnswers.last
    ];
    answers.shuffle();
    var size = MediaQuery.of(context).size;
    return SizedBox(
      child: Scaffold(
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
          Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
              child: Column(children: [
                timer(
                  animation: StepTween(begin: time, end: 0).animate(controller),
                ),
                Text(
                  widget.prompt,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                answers.first,
                answers.elementAt(1),
                answers.elementAt(2),
                answers.last,
              ])),
          Text(widget.player.username + " :" + widget.currentScore.toString(),
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
        ]),
        resizeToAvoidBottomInset: true,
      ),
      height: size.height,
      width: size.width,
    );
  }
}
