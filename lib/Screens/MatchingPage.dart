import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Backend%20Management/fireConnect.dart';
import 'package:quizup_prototype_1/Quiz%20components/quiz.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import 'package:quizup_prototype_1/Utilities/question_template.dart';
import 'Home.dart';

class MatchingPge extends StatelessWidget {
  final String subject;
  final Player player;
  late final Player opponent;
  static const _questionNumber = 7;
  bool oppfound = false;
  // ignore: prefer_const_constructors_in_immutables
  MatchingPge({Key? key, required this.subject, required this.player})
      : super(key: key);
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
    var games = await FirebaseFirestore.instance
        .collection('Contests')
        .doc(subject)
        .collection('contests')
        .where('Player2', isEqualTo: "")
        .get();
    if (games.docs.isEmpty) {
      var questions = await FireConnect.readQuestions(subject, _questionNumber);
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

  @override
  Widget build(BuildContext context) {
    findOpponent(player, subject, context);
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
