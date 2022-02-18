import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/answer.dart';

class Question extends StatelessWidget {
  final String prompt;
  final List<String> wrongAnswersTxt;
  final String correctAnswerTxt;
  final String subject;
  late final bool increaseScore;
  bool hasFinished = false;
  Question(
      {Key? key,
      required this.prompt,
      required this.wrongAnswersTxt,
      required this.correctAnswerTxt,
      required this.subject})
      : super(key: key);
  late final Answer correctAnswer = Answer(
      ans: correctAnswerTxt,
      colorOnPress: Colors.green,
      ontap: () => {increaseScore = true, hasFinished = true});
  late final List<Answer> wrongAnswers = wrongAnswersTxt
      .map((e) => Answer(
            ans: e,
            colorOnPress: Colors.red,
            ontap: () => {increaseScore = false, hasFinished = true},
          ))
      .toList();
  late final List<Widget> answers = [
    Text(
      prompt,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    correctAnswer,
    wrongAnswers.first,
    wrongAnswers.elementAt(1),
    wrongAnswers.last
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            subject,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          titleTextStyle: const TextStyle(fontStyle: FontStyle.italic),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 52, 80, 92),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
            child: Column(children: answers)));
  }
}
