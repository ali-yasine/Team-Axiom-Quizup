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
    print("Gameid: $gameID");
    var gameref =
        FirebaseFirestore.instance.collection("contest").doc(gameID.toString());
    var gameMade = false;
    gameref.snapshots().listen((event) {
      gameMade = true;
    });
    await waitforData(gameref);
    var data = await gameref.get();
    print("data: ${data.exists}");
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
    print(questionTemplates.length);
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
    const img = AssetImage('assets/images/panda.jpg');
    const backgroundColor = Color.fromRGBO(207, 232, 255, 20);
    const _iconSize = 40.0;
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(children: [
          Container(
            child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomePage(
                            player: player,
                          ))),
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              iconSize: _iconSize,
            ),
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.all(10),
          ),
          Container(
              alignment: Alignment.center,
              child: Text(subject,
                  style: const TextStyle(
                      fontSize: 35,
                      color: Color.fromRGBO(51, 156, 254, 10),
                      fontWeight: FontWeight.bold))),
          const SizedBox(height: 30),
          Container(
              width: 300,
              height: 150,
              decoration: BoxDecoration(
                  image: const DecorationImage(image: img, fit: BoxFit.fill),
                  color: Colors.white,
                  border: Border.all(
                    color: const Color.fromRGBO(51, 156, 254, 10),
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(25))),
              child: ClipRRect(
                //used to make circular borders
                borderRadius: BorderRadius.circular(15),
              )),
          const SizedBox(height: 20),
          Container(
              margin: const EdgeInsets.only(left: 30.0),
              alignment: Alignment.centerLeft,
              child: const Text("Player 1 ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(51, 156, 254, 10)))),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                  child: const CircleAvatar(
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey,
                        backgroundImage: img,
                      ),
                      radius: 47),
                  margin: const EdgeInsets.only(left: 10, bottom: 40)),
              Container(
                  margin: const EdgeInsets.only(right: 15.0),
                  width: 250,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromRGBO(51, 156, 254, 10),
                        width: 1,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: ClipRRect(
                      //used to make circular borders
                      borderRadius: BorderRadius.circular(15),
                      child: Center(
                          child: Text(
                        player.username,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(51, 156, 254, 10)),
                        textAlign: TextAlign.center,
                      )))),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              margin: const EdgeInsets.only(left: 30.0),
              alignment: Alignment.centerLeft,
              child: const Text("Player 2 ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(51, 156, 254, 10)))),
          const SizedBox(
            height: 5,
          ),
          Container(
              margin: const EdgeInsets.only(left: 30.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                  "Please wait , we are assigning a player for you",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, color: Colors.grey))),
          const CircularProgressIndicator(),
        ]));
  }
}
