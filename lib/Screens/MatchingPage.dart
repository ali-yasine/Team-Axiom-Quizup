import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Backend%20Management/matchMaker.dart';
import 'package:quizup_prototype_1/Quiz%20components/quiz.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import 'package:quizup_prototype_1/Utilities/question_template.dart';
import 'Home.dart';

class MatchingPage extends StatelessWidget {
  final String subject;
  final Player player;
  late int gameID;
  List<QuestionTemplate> questionTemplates = [];
  late int playerNum;
  MatchingPage({
    Key? key,
    required this.subject,
    required this.player,
  }) : super(key: key);
  Future hasFoundOpponent() async {
    gameID = await MatchMaker.getGameId();
    var gameref =
        FirebaseFirestore.instance.collection("contest").doc(gameID.toString());
    var gameMade = false;
    gameref.snapshots().listen((event) {
      gameMade = true;
    });
    await waitforData(gameref);
    var data = await gameref.get();
    playerNum = data["Player1"] == player.username ? 1 : 2;
  }

  Future<void> waitforData(DocumentReference<Map<String, dynamic>> ref) async {
    while (!((await ref.get()).exists)) {}
  }

  Future<void> getQuestions() async {
    var docData = await (FirebaseFirestore.instance
            .collection("contest")
            .doc(gameID.toString()))
        .get();
    questionTemplates = docData["Questions"]
        .map<QuestionTemplate>((elem) => QuestionTemplate.fromJson(elem))
        .toList();
  }

  Future<void> startMatch(context) async {
    await hasFoundOpponent();
    await getQuestions();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Quiz(
              player: player,
              gameID: gameID,
              subject: subject,
              questionTemplates: questionTemplates,
              playerNum: playerNum,
            )));
  }

  @override
  Widget build(BuildContext context) {
    MatchMaker.findOpponent(player, subject);
    startMatch(context);

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Container(
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 30.0),
                child: const Text(
                    "Please wait , we are assigning a player for you",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 28, 109, 175)))),
          ),
          const CircularProgressIndicator(),
        ]));
  }
}
