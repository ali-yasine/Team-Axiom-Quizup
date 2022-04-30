import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../Utilities/player.dart';
import 'answer.dart';
import 'timer.dart';

class Question extends StatefulWidget {
  final String prompt;
  final List<String> wrongAnswersTxt;
  final String correctAnswerTxt;
  final String subject;
  final Player player;
  final bool isChallenge;
  int opponentScore;
  int questionNum;
  int currentScore;
  final int playerNum;
  final Player opponent;
  final VoidCallback onFinish;
  final String gameID;
  // ignore: prefer_const_constructors_in_immutables
  Question(
      {Key? key,
      required this.isChallenge,
      required this.questionNum,
      required this.opponentScore,
      required this.gameID,
      required this.prompt,
      required this.opponent,
      required this.wrongAnswersTxt,
      required this.correctAnswerTxt,
      required this.currentScore,
      required this.playerNum,
      required this.subject,
      required this.player,
      required this.onFinish})
      : super(key: key);
  late bool increaseScore;
  late int timeTaken;

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> with TickerProviderStateMixin {
  bool hasAnswered = false;
  bool shuffled = false;
  List<Answer>? answers;
  static const int time = 10; //Time for each question
  late final String playerNum;
  late final String opponentNum;
  late Timer timer;
  late Timer opponentTimer;
  @override
  void initState() {
    playerNum = "Player" + widget.playerNum.toString();
    int opponentIntNum = widget.playerNum == 1 ? 2 : 1;
    opponentNum = "Player" + opponentIntNum.toString();
    beginTimer();
    beginListener();
    super.initState();
  }

  @override
  void dispose() {
    if (timer.controller != null) {
      timer.controller!.dispose();
    }
    if (opponentTimer.controller != null) {
      opponentTimer.controller!.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Question oldWidget) {
    super.didUpdateWidget(oldWidget);
    hasAnswered = false;
    shuffled = false;
    answers = null;
    beginTimer();
  }

  void done(bool incScore) {
    widget.increaseScore = incScore;
    widget.timeTaken = timer.timeTaken;
    hasAnswered = true;
    if (widget.increaseScore) {
      widget.currentScore += 10 - (timer.timeTaken);
    }
    setState(() {});
    updateDoc();
  }

  Future<void> updateDoc() async {
    DocumentReference<Map<String, dynamic>> game;

    if (!widget.isChallenge) {
      game = FirebaseFirestore.instance
          .collection('Contests')
          .doc(widget.subject)
          .collection('contests')
          .doc(widget.gameID);
    } else {
      game = FirebaseFirestore.instance
          .collection('Challenges')
          .doc(widget.gameID);
    }
    game.update({
      (playerNum + " Score"): widget.currentScore,
      (playerNum + " Answered " + widget.questionNum.toString()): true
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

  void makeAnswers(bool hasAnswered) {
    if (answers == null) {
      final Answer correctAnswer = Answer(
          prompt: widget.prompt,
          ans: widget.correctAnswerTxt,
          handleAnimation: () => timer.stop(),
          colorOnPress: Colors.green,
          ontap: () => {done(true)});
      final List<Answer> wrongAnswers = widget.wrongAnswersTxt
          .map((e) => Answer(
                prompt: widget.prompt,
                ans: e,
                colorOnPress: Colors.red,
                handleAnimation: () => timer.stop(),
                ontap: () => {done(false)},
                isDisabled: hasAnswered,
              ))
          .toList();
      answers = [
        correctAnswer,
        wrongAnswers.first,
        wrongAnswers.elementAt(1),
        wrongAnswers.last
      ];
      answers!.shuffle();
    } else {
      answers = answers!
          .map((e) => Answer(
                ans: e.ans,
                prompt: e.prompt,
                colorOnPress: e.colorOnPress,
                ontap: e.ontap,
                handleAnimation: e.handleAnimation,
                isDisabled: hasAnswered,
              ))
          .toList();
    }
  }

  void beginListener() {
    DocumentReference<Map<String, dynamic>> game;
    if (!widget.isChallenge) {
      game = FirebaseFirestore.instance
          .collection('Contests')
          .doc(widget.subject)
          .collection('contests')
          .doc(widget.gameID);
    } else {
      game = FirebaseFirestore.instance
          .collection('Challenges')
          .doc(widget.gameID);
    }
    game.snapshots().listen((event) {
      if ((event.data())![
          opponentNum + " Answered " + widget.questionNum.toString()]) {
        opponentTimer.stop();

        setState(() {});
      }
      if ((event.data())![
              opponentNum + " Answered " + widget.questionNum.toString()] &&
          (event.data())![
              playerNum + " Answered " + widget.questionNum.toString()]) {
        widget.opponentScore = event.data()![opponentNum + " Score"];
        Future.delayed(const Duration(milliseconds: 500))
            .then((value) => widget.onFinish());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    makeAnswers(hasAnswered);
    double _width = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    Color blue = Color.fromARGB(255, 13, 77, 174);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: _width,
          height: 140,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                blue,
                const Color.fromARGB(255, 159, 31, 31),
              ],
            ),
          ),
          child: Column(children: [
            Flexible(
                flex: 2,
                child: Container(
                  color: Colors.transparent,
                )),
            Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Column contents vertically,
                crossAxisAlignment: CrossAxisAlignment
                    .center, //Center Column contents horizontally,
                children: [
                  Flexible(
                    flex: 25,
                    child: Container(
                      width: 60,
                      height: 60,
                      margin: const EdgeInsets.only(left: 5, right: 10),
                      child: CircleAvatar(
                        child: CircleAvatar(
                          radius: 33,
                          backgroundColor: Colors.grey,
                          child: widget.player.avatar,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                      )),
                  Flexible(
                    flex: 25,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Text(
                              " " +
                                  widget.player.username +
                                  " :" +
                                  widget.currentScore.toString() +
                                  " ",
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black)),
                        )),
                  ),
                  Flexible(
                      flex: 16,
                      child: Container(
                        color: Colors.white,
                      )),
                  Flexible(
                    flex: 10,
                    child: Text("vs",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  Flexible(
                      flex: 16,
                      child: Container(
                        color: Colors.white,
                      )),
                  Flexible(
                    flex: 25,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Text(
                              " " +
                                  widget.opponent.username +
                                  " :" +
                                  widget.opponentScore.toString() +
                                  " ",
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black)),
                        )),
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                      )),
                  Flexible(
                    flex: 25,
                    child: Container(
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        child: CircleAvatar(
                          radius: 33,
                          backgroundColor: Colors.grey,
                          child: widget.opponent.avatar,
                        ),
                      ),
                    ),
                  ),
                ])
          ]),
        ),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Neumorphic(
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.concave,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(12)),
                            depth: 30,
                            lightSource: LightSource.bottom,
                            color: Color.fromARGB(255, 234, 231, 231)),
                        child: ClipRRect(
                            //used to make circular borders
                            borderRadius: BorderRadius.circular(15),
                            child: Center(
                                child: Text(
                              widget.prompt,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            )))),
                  ),
                  const SizedBox(height: 60),
                  answers!.first,
                  const SizedBox(height: 20),
                  answers!.elementAt(1),
                  const SizedBox(height: 20),
                  answers!.elementAt(2),
                  const SizedBox(height: 20),
                  answers!.last,
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
