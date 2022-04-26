// ignore_for_file: file_names

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Backend%20Management/fireConnect.dart';
import 'package:quizup_prototype_1/Quiz%20components/quiz.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import 'package:quizup_prototype_1/Utilities/question_template.dart';
import 'Home.dart';

class MatchingPge extends StatefulWidget {
  final String subject;
  final Player player;
  static const _questionNumber = 7;

  const MatchingPge({Key? key, required this.subject, required this.player})
      : super(key: key);

  @override
  State<MatchingPge> createState() => _MatchingPgeState();
}

class _MatchingPgeState extends State<MatchingPge> {
  late final Player opponent;
  bool oppfound = false;
  DocumentReference<Map<String, dynamic>>? _gameDoc;
  Future<int> getGameId(String subject) async {
    var doc = await FirebaseFirestore.instance
        .collection('Contests')
        .doc(subject)
        .get();
    return doc['CurrentID'];
  }

  Future<void> incGameId(String subject) async {
    var id = await getGameId(subject);
    FirebaseFirestore.instance
        .collection("Contests")
        .doc(subject)
        .set({'CurrentID': id + 1});
  }

  Future<void> findOpponent(
      Player player, String subject, BuildContext context) async {
    var delay = Random().nextInt(1250);
    await Future.delayed(Duration(milliseconds: delay));
    var games = await FirebaseFirestore.instance
        .collection('Contests')
        .doc(subject)
        .collection('contests')
        .where('Player2', isEqualTo: "")
        .get();
    if (games.docs.isEmpty) {
      var questions =
          await FireConnect.readQuestions(subject, MatchingPge._questionNumber);
      createContest(player, subject, questions, context);
    } else {
      var gamedoc = games.docs.first;
      var gameID = gamedoc.reference.id;
      await gamedoc.reference.update({"Player2": player.username});
      Player opponent = await FireConnect.getPlayer(gamedoc.data()["Player1"]);
      List<QuestionTemplate> questions = gamedoc
          .data()["Questions"]
          .map<QuestionTemplate>((e) => QuestionTemplate.fromJson(e))
          .toList();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Quiz(
              opponent: opponent,
              questionTemplates: questions,
              player: player,
              gameID: int.parse(gameID),
              playerNum: 2,
              subject: subject)));
    }
  }

  Future<void> createContest(Player player, String subject,
      List<QuestionTemplate> questions, BuildContext context) async {
    var gameID = await getGameId(subject);
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
    var gamedoc = FirebaseFirestore.instance
        .collection('Contests')
        .doc(subject)
        .collection('contests')
        .doc(gameID.toString());
    gamedoc.set(entryMap);
    incGameId(subject);
    _gameDoc = gamedoc;
    gamedoc.snapshots().listen((event) async {
      if (!oppfound) {
        if (event.data()!["Player2"] != "") {
          opponent = await FireConnect.getPlayer(event.data()!["Player2"]);
          oppfound = true;
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Quiz(
                  opponent: opponent,
                  questionTemplates: questions,
                  player: player,
                  gameID: gameID,
                  playerNum: 1,
                  subject: subject)));
        }
      }
    });
  }

  Future<void> removeGameDoc(
      DocumentReference<Map<String, dynamic>>? gamedoc) async {
    if (gamedoc != null) {
      var data = await gamedoc.get();
      if (data.data()!["Player2"] == "") {
        gamedoc.delete();
      }
    }
  }

  @override
  void dispose() {
    removeGameDoc(_gameDoc);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    findOpponent(widget.player, widget.subject, context);
    const img = AssetImage('assets/images/panda.jpg');

    const _iconSize = 40.0;
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                child: Text(
                  ("Please wait, we are assigning a player for you"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30, color: Color.fromARGB(255, 13, 77, 174)),
                ),
              ),
              CircularProgressIndicator(),
            ]));
  }
}
