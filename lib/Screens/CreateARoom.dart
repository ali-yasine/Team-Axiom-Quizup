// ignore_for_file: must_be_immutable, file_names

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Backend Management/fireConnect.dart';
import '../OfflineQuiz/offlineQuiz.dart';
import '../Quiz components/quiz.dart';
import '../Utilities/player.dart';
import '../Utilities/question_template.dart';
import 'Home.dart';

class CreateARoom extends StatefulWidget {
  final String subject;
  final Player player;

  const CreateARoom({
    Key? key,
    required this.subject,
    required this.player,
  }) : super(key: key);

  @override
  State<CreateARoom> createState() => _CreateARoomState();
}

class _CreateARoomState extends State<CreateARoom> {
  bool oppfound = false;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? listener;
  DocumentReference<Map<String, dynamic>>? gamedoc;
  TextEditingController opponentUsernameController = TextEditingController();
  String generateToken(int length) {
    const ch = '1234567890';
    Random r = Random();
    return String.fromCharCodes(
        Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }

  Future<void> removeGameDoc(
      DocumentReference<Map<String, dynamic>>? gamedoc) async {
    if (gamedoc != null) {
      if (!oppfound) {
        gamedoc.delete();
      }
    }
    if (!(listener == null)) {
      listener!.cancel();
    }
  }

  @override
  void dispose() {
    removeGameDoc(gamedoc);
    super.dispose();
  }

  Future<void> createOfflineChallenge(
      Player player, String subject, BuildContext context, String id) async {
    var questions = await FireConnect.readQuestions(subject, 7);
    Map<String, dynamic> hasAnswered = {};
    for (int i = 0; i < questions.length; i++) {
      hasAnswered.addAll({
        "Player1 Answered " + i.toString(): false,
        "Player2 Answered " + i.toString(): false
      });
    }
    Map<String, dynamic> entryMap = {
      ("Player1"): player.username,
      ("Player2"): "",
      "Questions": questions.map((e) => QuestionTemplate.toJson(e)).toList(),
      "Player1 Score": 0,
      "Player2 Score": 0,
    };
    entryMap.addAll(hasAnswered);
    gamedoc = FirebaseFirestore.instance.collection('Challenges').doc(id);
    gamedoc!.set(entryMap);
  }

  Future<void> createRoom(
      Player player, String subject, BuildContext context, String id) async {
    var questions = await FireConnect.readQuestions(subject, 7);
    Map<String, dynamic> hasAnswered = {};
    for (int i = 0; i < questions.length; i++) {
      hasAnswered.addAll({
        "Player1 Answered " + i.toString(): false,
        "Player2 Answered " + i.toString(): false
      });
    }
    Map<String, dynamic> entryMap = {
      ("Player1"): player.username,
      ("Player2"): "",
      "Questions": questions.map((e) => QuestionTemplate.toJson(e)).toList(),
      "Player1 Score": 0,
      "Player2 Score": 0,
    };
    entryMap.addAll(hasAnswered);
    gamedoc = FirebaseFirestore.instance.collection('Challenges').doc(id);
    await gamedoc!.set(entryMap);
    listener = gamedoc!.snapshots().listen((event) async {
      if (!oppfound) {
        if (event.data() != null) {
          if (event.data()!["Player2"] != "") {
            var opponent =
                await FireConnect.getPlayer(event.data()!["Player2"]);
            oppfound = true;
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Quiz(
                    isChallenge: true,
                    opponent: opponent,
                    questionTemplates: questions,
                    player: player,
                    gameID: id,
                    playerNum: 1,
                    subject: subject)));
          }
        }
      }
    });
  }

  Future offlineContestCreate(
      Player player, String subject, BuildContext context, String id) async {
    if (opponentUsernameController.text == "") {
      Fluttertoast.showToast(msg: "Opponent username can't be empty");
    } else {
      var questions = await FireConnect.readQuestions(subject, 7);
      Map<String, dynamic> hasAnswered = {};
      for (int i = 0; i < questions.length; i++) {
        hasAnswered.addAll({
          "Player1 Answered " + i.toString(): false,
          "Player2 Answered " + i.toString(): false
        });
      }
      Map<String, dynamic> entryMap = {
        ("Player1"): player.username,
        "Player2 notified": false,
        "subject": subject,
        ("Player2"): opponentUsernameController.text,
        "Questions": questions.map((e) => QuestionTemplate.toJson(e)).toList(),
        "Player1 Score": 0,
        "Player2 Score": 0,
      };
      entryMap.addAll(hasAnswered);
      gamedoc =
          FirebaseFirestore.instance.collection('OfflineChallenges').doc(id);
      await (gamedoc!.set(entryMap));
      print("gameDocSet");
      oppfound = true;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => OfflineQuiz(
              questionTemplates: questions,
              player: player,
              opponentScore: 0,
              gameID: id,
              playerNum: 1,
              subject: subject)));
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    var token = generateToken(6);

    Color blue = const Color.fromARGB(255, 13, 77, 174);
    createRoom(widget.player, widget.subject, context, token);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(children: [
        Flexible(
            child: Container(
              width: _width,
              height: 120,
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
              child: Row(children: [
                Container(
                  width: 70,
                  height: 70,
                  margin: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                    child: ClipOval(
                      child: widget.player.avatar,
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    width: 150,
                    height: 30,
                    color: Colors.transparent,
                    child: ClipRRect(
                        //used to make circular borders
                        borderRadius: BorderRadius.circular(15),
                        child: Center(
                            child: Text(
                          widget.player.username,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[300],
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )))),
              ]),
            ),
            flex: 20),
        Flexible(
            flex: 5,
            child: Container(
              color: Colors.grey[300],
            )),
        Flexible(
            child: Container(
              width: _width - 20,
              child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    depth: 30,
                    lightSource: LightSource.bottom,
                    color: Color.fromARGB(255, 232, 229, 229)),
                child: const Center(
                    child: Text(
                  "Join A Room",
                  style: TextStyle(fontSize: 26, color: Colors.black),
                  textAlign: TextAlign.center,
                )),
              ),
            ),
            flex: 5),
        Flexible(
            flex: 4,
            child: Container(
              color: Colors.grey[300],
            )),
        Flexible(
            child: Row(children: [
              Flexible(
                flex: 20,
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Neumorphic(
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                          depth: 30,
                          lightSource: LightSource.top,
                          color: Color.fromARGB(255, 232, 229, 229)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Center(
                              child: FittedBox(
                                  child: Text(
                                    token,
                                    style: const TextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                  fit: BoxFit.cover)))),
                ),
              ),
              Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.grey[300],
                  )),
              Flexible(
                  flex: 8,
                  child: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20.0,
                          color: Color.fromARGB(255, 125, 125, 125),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: ElevatedButton(
                          onPressed: () =>
                              {Clipboard.setData(ClipboardData(text: token))},
                          child: FittedBox(
                              child: Text(
                                "copy",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey[300]),
                                textAlign: TextAlign.center,
                              ),
                              fit: BoxFit.fill),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 13, 77, 174),
                          )),
                        )),
                  )),
            ]),
            flex: 4),
        Flexible(
            flex: 2,
            child: Container(
              color: Colors.grey[300],
            )),
        Flexible(
          flex: 5,
          child: Center(
            child: Container(
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
                child: const Text("Please wait for your friend to join",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 28, 109, 175)))),
          ),
        ),
        Flexible(
            flex: 3,
            child: Container(
              color: Colors.grey[300],
            )),
        const CircularProgressIndicator(),
        Flexible(
            flex: 3,
            child: Container(
              color: Colors.grey[300],
            )),
        Flexible(
          flex: 30,
          child: Container(
            child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    depth: 30,
                    lightSource: LightSource.top,
                    color: Color.fromARGB(255, 243, 243, 243)),
                child: ClipRRect(
                  //used to make circular borders
                  borderRadius: BorderRadius.circular(30),
                  child: TextField(
                    controller: opponentUsernameController,
                    decoration: const InputDecoration(
                      labelText:
                          '  Enter opponent username to notify him fo the challenge',
                    ),
                  ),
                )),
          ),
        ),
        Flexible(
            flex: 3,
            child: Container(
              color: Colors.grey[300],
            )),
        Flexible(
            flex: 10,
            child: Center(
              child: Container(
                height: 50,
                width: _width / 2,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20.0,
                      color: Color.fromARGB(255, 190, 189, 189),
                    ),
                  ],
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ElevatedButton(
                      onPressed: () => offlineContestCreate(
                          widget.player, widget.subject, context, token),
                      child: const Text(
                        "Play offline",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 13, 77, 174),
                      )),
                    )),
              ),
            )),
      ]),
    );
  }
}
