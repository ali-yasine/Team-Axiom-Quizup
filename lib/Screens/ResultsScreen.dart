import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Screens/Leaderboard.dart';
import 'package:quizup_prototype_1/Screens/ReportAQuestion.dart';
import 'package:quizup_prototype_1/Screens/subject_screen.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';

import '../Backend Management/fireConnect.dart';
import 'Home.dart';

class Results extends StatelessWidget {
  final Player player;
  final int score;
  final String subject;
  final int correct;
  final int incorrect;
  final int opponentScore;
  const Results(
      {Key? key,
      required this.player,
      required this.score,
      required this.subject,
      required this.correct,
      required this.incorrect,
      required this.opponentScore})
      : super(key: key);
  Future<void> updateLeaderBoard() async {
    updateGlobalLeaderboard();
    updateSubjectLeaderboard();
  }

  Future writeSubjects() async {
    var subjects = await FireConnect.getSubjects();
    for (var subject in subjects) {
      var subjectDoc = await FirebaseFirestore.instance
          .collection('Leaderboard')
          .doc(subject)
          .get();
      if (!subjectDoc.exists) {
        FirebaseFirestore.instance
            .collection('Leaderboard')
            .doc(subject)
            .set({'players': {}});
      }
    }
  }

  Future<void> updateSubjectLeaderboard() async {
    var subjectdoc = await FirebaseFirestore.instance
        .collection('Leaderboard')
        .doc(subject)
        .get();
    if (subjectdoc.data()!['players'] != null) {
      var info = subjectdoc.data()!['players'][player.username];
      if (info != null) {
        if (score > opponentScore) {
          FirebaseFirestore.instance
              .collection('Leaderboard')
              .doc(subject)
              .update({
            'players.${player.username}': [info[0], info[1] + 10]
          });
        } else if (score < opponentScore) {
          FirebaseFirestore.instance
              .collection('Leaderboard')
              .doc(subject)
              .update({
            'players.${player.username}': [info[0], info[1] - 10]
          });
        }
      } else {
        if (score > opponentScore) {
          FirebaseFirestore.instance
              .collection('Leaderboard')
              .doc(subject)
              .update({
            'players.${player.username}': [player.country, 110]
          });
        } else if (score < opponentScore) {
          FirebaseFirestore.instance
              .collection('Leaderboard')
              .doc(subject)
              .update({
            'players.${player.username}': [player.country, 90]
          });
        }
      }
    }
  }

  Future<void> updateGlobalLeaderboard() async {
    var global = await FirebaseFirestore.instance
        .collection('Leaderboard')
        .doc('Global')
        .get();
    var info = global.data()!['players'][player.username];
    if (score > opponentScore) {
      if (info != null) {
        FirebaseFirestore.instance
            .collection('Leaderboard')
            .doc('Global')
            .update({
          'players.${player.username}': [info[0], info[1] + 10]
        });
      } else {
        FirebaseFirestore.instance
            .collection('Leaderboard')
            .doc('Global')
            .update({
          'players.${player.username}': [player.country, 110]
        });
      }
    } else if (score < opponentScore) {
      FirebaseFirestore.instance
          .collection('Leaderboard')
          .doc('Global')
          .update({
        'players.${player.username}': [player.username, 90]
      });
    }
  }

  Widget getResult(int score, int opponentScore) {
    if (score > opponentScore) {
      return Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.green,
              border: Border.all(
                color: const Color.fromARGB(255, 13, 77, 174),
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          child: ClipRRect(
              //used to make circular borders
              borderRadius: BorderRadius.circular(15),
              child: const Center(
                  child: Text(
                "Congratulations! You won",
                style: TextStyle(fontSize: 26, color: Colors.white),
                textAlign: TextAlign.center,
              ))));
    } else if (score == opponentScore) {
      return Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.yellow[600],
              border: Border.all(
                color: Color.fromARGB(255, 255, 230, 0),
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          child: ClipRRect(
              //used to make circular borders
              borderRadius: BorderRadius.circular(15),
              child: const Center(
                  child: Text(
                "Tie",
                style: TextStyle(fontSize: 26, color: Colors.white),
                textAlign: TextAlign.center,
              ))));
    } else {
      return Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(
                color: const Color.fromARGB(255, 13, 77, 174),
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          child: ClipRRect(
              //used to make circular borders
              borderRadius: BorderRadius.circular(15),
              child: const Center(
                  child: Text(
                "Sorry, you lost",
                style: TextStyle(fontSize: 26, color: Colors.white),
                textAlign: TextAlign.center,
              ))));
    }
  }

  @override
  Widget build(BuildContext context) {
    updateLeaderBoard();
    final subjectImage = AssetImage('assets/images/${subject}.jpeg');
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(children: [
          Flexible(
              flex: 4,
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
                child: Center(
                    child: Text(
                  subject,
                  style: const TextStyle(
                      fontSize: 26, color: Color.fromARGB(255, 13, 77, 174)),
                  textAlign: TextAlign.center,
                )),
              ),
              flex: 10),
          Flexible(
              flex: 4,
              child: Container(
                color: Colors.grey[300],
              )),
          Flexible(
              child: Container(
                width: 300,
                height: 250,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: subjectImage, fit: BoxFit.fill),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 13, 77, 174),
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
              ),
              flex: 20),
          Flexible(
              flex: 2,
              child: Container(
                color: Colors.grey[300],
              )),
          Flexible(
              child: Container(
                  margin: const EdgeInsets.only(left: 30.0),
                  alignment: Alignment.centerLeft,
                  child: const Text("Player ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 13, 77, 174)))),
              flex: 7),
          Flexible(
            child: Row(children: [
              Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.grey[300],
                  )),
              Container(
                child: CircleAvatar(
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.grey,
                      child: player.avatar,
                    ),
                    radius: 47),
              ),
              Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.grey[300],
                  )),
              Flexible(
                  flex: 15,
                  child: Column(children: [
                    Container(
                        width: 250,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color.fromARGB(255, 13, 77, 174),
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
                                  color: Color.fromARGB(255, 13, 77, 174)),
                              textAlign: TextAlign.center,
                            )))),
                    Flexible(
                        flex: 1,
                        child: Container(
                          color: Colors.grey[300],
                        )),
                    Flexible(
                        flex: 3,
                        child: Row(children: [
                          Flexible(
                              flex: 2,
                              child: Container(
                                color: Colors.grey[300],
                              )),
                          Flexible(
                              flex: 15,
                              child: Container(
                                  width: 80,
                                  height: 38,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 13, 77, 174),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25))),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Center(
                                          child: Text(
                                        score.toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 13, 77, 174)),
                                        textAlign: TextAlign.center,
                                      ))))),
                          Flexible(
                              flex: 15,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 5.0),
                                  width: 80,
                                  height: 38,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 13, 77, 174),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25))),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Center(
                                          child: Text(
                                        correct.toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 13, 77, 174)),
                                        textAlign: TextAlign.center,
                                      ))))),
                          Flexible(
                              flex: 15,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 5.0),
                                  width: 80,
                                  height: 38,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 13, 77, 174),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25))),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Center(
                                          child: Text(
                                        incorrect.toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 13, 77, 174)),
                                        textAlign: TextAlign.center,
                                      ))))),
                          Flexible(
                              flex: 15,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 5.0),
                                  width: 80,
                                  height: 38,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 13, 77, 174),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25))),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Center(
                                          child: Text(
                                        opponentScore.toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 13, 77, 174)),
                                        textAlign: TextAlign.center,
                                      ))))),
                        ])),
                    Row(
                      children: [
                        const Flexible(
                          flex: 15,
                          child: SizedBox(
                              height: 38,
                              child: Center(
                                  child: Text(
                                "score",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 13, 77, 174),
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ))),
                        ),
                        Flexible(
                          flex: 15,
                          child: Container(
                              margin: const EdgeInsets.only(left: 2.5),
                              height: 38,
                              child: const Center(
                                  child: Text(
                                " correct answer",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 13, 77, 174),
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ))),
                        ),
                        Flexible(
                          flex: 15,
                          child: Container(
                              margin: const EdgeInsets.only(left: 2.5),
                              width: 80,
                              height: 38,
                              child: const Center(
                                  child: Text(
                                "incorrect answer",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 13, 77, 174),
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ))),
                        ),
                        Flexible(
                          flex: 15,
                          child: Container(
                              margin: const EdgeInsets.only(left: 2.5),
                              height: 38,
                              child: const Center(
                                  child: Text(
                                "opponent score",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 13, 77, 174),
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ))),
                        ),
                      ],
                    )
                  ]))
            ]),
            flex: 17,
          ),
          Flexible(
              flex: 1,
              child: Container(
                color: Colors.grey[300],
              )),
          Flexible(child: getResult(score, opponentScore), flex: 25),
          Flexible(
              flex: 1,
              child: Container(
                color: Colors.grey[300],
              )),
          Flexible(
            child: Row(children: [
              Flexible(
                flex: 17,
                child: Container(
                    margin: const EdgeInsets.only(left: 30.0),
                    width: 100,
                    height: 50,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => Leaderboard(
                                        player: player,
                                      ))),
                          child: const Text(
                            "Leaderboard",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 13, 77, 174),
                          )),
                        ))),
              ),
              Flexible(
                  flex: 16,
                  child: Container(
                      margin: const EdgeInsets.only(left: 25.0),
                      width: 100,
                      height: 50,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => HomePage(
                                          player: player,
                                        ))),
                            child: const Text(
                              "Home",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 13, 77, 174),
                            )),
                          )))),
              Flexible(
                  flex: 16,
                  child: Container(
                      margin: const EdgeInsets.only(left: 25.0),
                      width: 100,
                      height: 50,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => SubjectScreen(
                                          subject: subject,
                                          player: player,
                                        ))),
                            child: const Text(
                              "Play again",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 13, 77, 174),
                            )),
                          )))),
              Flexible(
                  flex: 16,
                  child: Container(
                      margin: const EdgeInsets.only(left: 25.0),
                      width: 100,
                      height: 50,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => ReportAQuestion(
                                        subject: subject, player: player))),
                            child: const Text(
                              "Contest a question",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                              Colors.grey,
                            )),
                          )))),
              Flexible(
                  flex: 3,
                  child: Container(
                    color: Colors.grey[300],
                  ))
            ]),
            flex: 9,
          )
        ]));
  }
}
