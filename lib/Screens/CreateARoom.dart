// ignore_for_file: must_be_immutable, file_names

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizup_prototype_1/Backend%20Management/fireConnect.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import '../Quiz components/quiz.dart';
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
  DocumentReference<Map<String, dynamic>>? gamedoc;
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
  }

  @override
  void dispose() {
    removeGameDoc(gamedoc);
    super.dispose();
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
    gamedoc!.set(entryMap);
    gamedoc!.snapshots().listen((event) async {
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

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    const img = AssetImage('assets/images/panda.jpg');
    var token = generateToken(6);
    const _profileRadius = 35.0;
    const _iconSize = 40.0;
    createRoom(widget.player, widget.subject, context, token);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(children: [
        Flexible(
            child: Container(
          child: IconButton(
            onPressed: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => HomePage(
                          player: widget.player,
                        ))),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            iconSize: _iconSize,
          ),
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.all(10),
        )),
        Flexible(
            child: Row(children: [
              Container(
                  child: const CircleAvatar(
                      child: CircleAvatar(
                        radius: _profileRadius - 2,
                        backgroundColor: Colors.grey,
                        backgroundImage: img,
                      ),
                      radius: _profileRadius),
                  margin: const EdgeInsets.only(left: 10)),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 15),
                  width: 150,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromARGB(255, 13, 77, 174),
                        width: 1,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Center(
                          child: FittedBox(
                              child: Text(
                                widget.player.username,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 13, 77, 174)),
                                textAlign: TextAlign.center,
                              ),
                              fit: BoxFit.cover)))),
            ]),
            flex: 20),
        Flexible(
            flex: 5,
            child: Container(
              color: Colors.grey[300],
            )),
        Flexible(
            child: Container(
              width: _width - 20,
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: const Color.fromARGB(255, 13, 77, 174)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                  child: Text(
                " Create A Room",
                style: TextStyle(
                    fontSize: 26, color: Color.fromARGB(255, 13, 77, 174)),
                textAlign: TextAlign.center,
              )),
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
                    margin: const EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color.fromARGB(255, 13, 77, 174),
                          width: 1,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25))),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Center(
                            child: FittedBox(
                                child: Text(
                                  token,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 13, 77, 174)),
                                  textAlign: TextAlign.center,
                                ),
                                fit: BoxFit.cover)))),
              ),
              Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.grey[300],
                  )),
              Flexible(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: ElevatedButton(
                      onPressed: () =>
                          {Clipboard.setData(ClipboardData(text: token))},
                      child: const FittedBox(
                          child: Text(
                            "copy",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          fit: BoxFit.fill),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 13, 77, 174),
                      )),
                    )),
                flex: 8,
              )
            ]),
            flex: 2),
        Flexible(
            flex: 5,
            child: Container(
              color: Colors.grey[300],
            )),
        Center(
          child: Container(
              padding: const EdgeInsets.all(0.0),
              alignment: Alignment.center,
              child: const Text("Please wait for your friend to join",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 24, color: Color.fromARGB(255, 28, 109, 175)))),
        ),
        Flexible(
            flex: 1,
            child: Container(
              color: Colors.grey[300],
            )),
        const CircularProgressIndicator(),
      ]),
    );
  }
}
