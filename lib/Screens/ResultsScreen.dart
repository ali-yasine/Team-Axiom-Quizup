import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:quizup/Screens/subject_screen.dart';
import '../Backend Management/fireConnect.dart';
import '../Utilities/player.dart';
import 'Home.dart';
import 'Leaderboard.dart';
import 'ReportAQuestion.dart';

class Results extends StatelessWidget {
  final Player player;
  final int score;
  final String subject;
  final int correct;
  final int incorrect;
  final int opponentScore;
  final bool isChallenge;
  final Player opponent;
  const Results(
      {Key? key,
      required this.player,
      required this.opponent,
      required this.score,
      required this.subject,
      required this.correct,
      required this.isChallenge,
      required this.incorrect,
      required this.opponentScore})
      : super(key: key);
  Future<void> updateLeaderBoard() async {
    updateGlobalLeaderboard();
    updateSubjectLeaderboard();
    if (isChallenge) {
      updateOppGlobalLeaderboard();
      updateOppSubjectLeaderboard(subject);
    }
  }

  Future<void> updatePlayerData() async {
    var query = await FirebaseFirestore.instance
        .collection('Player')
        .where('Username', isEqualTo: player.username)
        .get();
    var playerdoc = query.docs.first;
    var playerData = playerdoc.data();
    playerdoc.reference.update({
      "GamesPlayed": playerData['GamesPlayed'] + 1,
      "GamesWon": playerData['GamesWon'] + (score > opponentScore ? 1 : 0)
    });
  }

  Future<void> updateSubjectPlayed() async {
    var playerdoc = await FirebaseFirestore.instance
        .collection('SubjectsPerPlayer')
        .doc(player.username)
        .get();
    if (playerdoc.exists) {
      if (playerdoc.data() != null) {
        if (playerdoc.data()!['subjects'] != null) {
          playerdoc.reference.update({
            'subjects.$subject':
                (playerdoc.data()!['subjects'][subject] == null)
                    ? 1
                    : 1 + playerdoc.data()!['subjects'][subject]
          });
        }
        playerdoc.reference.update({
          'subjects': {subject: 1}
        });
      }
    } else {
      playerdoc.reference.set({
        'subjects': {subject: 1}
      });
    }
  }

  Future updateOppGlobalLeaderboard() async {
    updateOppSubjectLeaderboard('Global');
  }

  Future updateOppSubjectLeaderboard(String subject) async {
    var subjectdoc = await FirebaseFirestore.instance
        .collection('Leaderboard')
        .doc(subject)
        .get();
    if (subjectdoc.data()!['players'] != null) {
      var info = subjectdoc.data()!['players'][opponent.username];
      if (info != null) {
        if (score < opponentScore) {
          FirebaseFirestore.instance
              .collection('Leaderboard')
              .doc(subject)
              .update({
            'players.${opponent.username}': [info[0], info[1] + 10]
          });
        } else if (score > opponentScore) {
          FirebaseFirestore.instance
              .collection('Leaderboard')
              .doc(subject)
              .update({
            'players.${opponent.username}': [info[0], info[1] - 10]
          });
        }
      } else {
        if (score < opponentScore) {
          FirebaseFirestore.instance
              .collection('Leaderboard')
              .doc(subject)
              .update({
            'players.${opponent.username}': [opponent.country, 110]
          });
        } else if (score < opponentScore) {
          FirebaseFirestore.instance
              .collection('Leaderboard')
              .doc(subject)
              .update({
            'players.${opponent.username}': [opponent.country, 90]
          });
        }
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
          child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                depth: 30,
                lightSource: LightSource.bottom,
                color: Colors.green,
              ),
              child: ClipRRect(
                  //used to make circular borders
                  borderRadius: BorderRadius.circular(15),
                  child: const Center(
                      child: Text(
                    "Congratulations! You won",
                    style: TextStyle(fontSize: 26, color: Colors.white),
                    textAlign: TextAlign.center,
                  )))));
    } else if (score == opponentScore) {
      return Container(
          width: 300,
          height: 150,
          child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                depth: 30,
                lightSource: LightSource.bottom,
                color: Colors.yellow,
              ),
              child: ClipRRect(
                  //used to make circular borders
                  borderRadius: BorderRadius.circular(15),
                  child: const Center(
                      child: Text(
                    "Tie",
                    style: TextStyle(fontSize: 26, color: Colors.white),
                    textAlign: TextAlign.center,
                  )))));
    } else {
      return Container(
          width: 300,
          height: 150,
          child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                depth: 30,
                lightSource: LightSource.bottom,
                color: Colors.red,
              ),
              child: ClipRRect(
                  //used to make circular borders
                  borderRadius: BorderRadius.circular(15),
                  child: const Center(
                      child: Text(
                    "Sorry, you lost",
                    style: TextStyle(fontSize: 26, color: Colors.white),
                    textAlign: TextAlign.center,
                  )))));
    }
  }

  @override
  Widget build(BuildContext context) {
    Color blue = Color.fromARGB(255, 13, 77, 174);

    updateLeaderBoard();
    final subjectImage = AssetImage('assets/images/$subject.jpeg');
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          Flexible(
              flex: 4,
              child: Container(
                color: Colors.white,
              )),
          Flexible(
              child: Container(
                width: _width - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      blue,
                      const Color.fromARGB(255, 159, 31, 31),
                    ],
                  ),
                ),
                child: Center(
                    child: Text(
                  subject,
                  style: const TextStyle(fontSize: 26, color: Colors.white),
                  textAlign: TextAlign.center,
                )),
              ),
              flex: 10),
          Flexible(
              flex: 4,
              child: Container(
                color: Colors.white,
              )),
          Flexible(
              child: Container(
                width: 300,
                height: 250,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: subjectImage, fit: BoxFit.fill),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
              ),
              flex: 20),
          Flexible(
              flex: 2,
              child: Container(
                color: Colors.white,
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
                          color: Colors.black))),
              flex: 7),
          Flexible(
            child: Row(children: [
              Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
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
                    color: Colors.white,
                  )),
              Flexible(
                  flex: 15,
                  child: Column(children: [
                    Container(
                      width: 250,
                      height: 35,
                      child: Neumorphic(
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.concave,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(12)),
                              depth: 30,
                              lightSource: LightSource.bottom,
                              color: Color.fromARGB(255, 242, 239, 239)),
                          child: ClipRRect(
                              //used to make circular borders
                              borderRadius: BorderRadius.circular(15),
                              child: Center(
                                  child: Text(
                                player.username,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                                textAlign: TextAlign.center,
                              )))),
                    ),
                    Flexible(
                        flex: 1,
                        child: Container(
                          color: Colors.white,
                        )),
                    Flexible(
                        flex: 3,
                        child: Row(children: [
                          Flexible(
                              flex: 2,
                              child: Container(
                                color: Colors.white,
                              )),
                          Flexible(
                              flex: 15,
                              child: Container(
                                  width: 80,
                                  height: 38,
                                  child: Neumorphic(
                                      style: NeumorphicStyle(
                                          shape: NeumorphicShape.concave,
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                                  BorderRadius.circular(12)),
                                          depth: 30,
                                          lightSource: LightSource.bottom,
                                          color: Color.fromARGB(
                                              255, 242, 239, 239)),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Center(
                                              child: Text(
                                            score.toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                            textAlign: TextAlign.center,
                                          )))))),
                          Flexible(
                            flex: 15,
                            child: Container(
                                margin: const EdgeInsets.only(left: 5.0),
                                width: 80,
                                height: 38,
                                child: Neumorphic(
                                    style: NeumorphicStyle(
                                        shape: NeumorphicShape.concave,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(12)),
                                        depth: 30,
                                        lightSource: LightSource.bottom,
                                        color:
                                            Color.fromARGB(255, 242, 239, 239)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Center(
                                            child: Text(
                                          correct.toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ))))),
                          ),
                          Flexible(
                            flex: 15,
                            child: Container(
                                margin: const EdgeInsets.only(left: 5.0),
                                width: 80,
                                height: 38,
                                child: Neumorphic(
                                    style: NeumorphicStyle(
                                        shape: NeumorphicShape.concave,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(12)),
                                        depth: 30,
                                        lightSource: LightSource.bottom,
                                        color:
                                            Color.fromARGB(255, 242, 239, 239)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Center(
                                            child: Text(
                                          incorrect.toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ))))),
                          ),
                          Flexible(
                              flex: 15,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 5.0),
                                  width: 80,
                                  height: 38,
                                  child: Neumorphic(
                                      style: NeumorphicStyle(
                                          shape: NeumorphicShape.concave,
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                                  BorderRadius.circular(12)),
                                          depth: 30,
                                          lightSource: LightSource.bottom,
                                          color: Color.fromARGB(
                                              255, 242, 239, 239)),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Center(
                                              child: Text(
                                            opponentScore.toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                            textAlign: TextAlign.center,
                                          )))))),
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
                                    color: Colors.black,
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
                                    color: Colors.black,
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
                                    color: Colors.black,
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
                                    color: Colors.black,
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
                color: Colors.white,
              )),
          Flexible(child: getResult(score, opponentScore), flex: 25),
          Flexible(
              flex: 1,
              child: Container(
                color: Colors.white,
              )),
          Flexible(
            child: Row(children: [
              Flexible(
                flex: 17,
                child: Container(
                    margin: const EdgeInsets.only(left: 30.0),
                    width: 100,
                    height: 50,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20.0,
                          color: Color.fromARGB(255, 125, 125, 125),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
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
                            blue,
                          )),
                        ))),
              ),
              Flexible(
                  flex: 16,
                  child: Container(
                      margin: const EdgeInsets.only(left: 25.0),
                      width: 100,
                      height: 50,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20.0,
                            color: Color.fromARGB(255, 125, 125, 125),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
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
                              blue,
                            )),
                          )))),
              Flexible(
                  flex: 16,
                  child: Container(
                      margin: const EdgeInsets.only(left: 25.0),
                      width: 100,
                      height: 50,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20.0,
                            color: Color.fromARGB(255, 125, 125, 125),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
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
                              blue,
                            )),
                          )))),
              Flexible(
                  flex: 16,
                  child: Container(
                      margin: const EdgeInsets.only(left: 25.0),
                      width: 100,
                      height: 50,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20.0,
                            color: Color.fromARGB(255, 125, 125, 125),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
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
                    color: Colors.grey[200],
                  ))
            ]),
            flex: 9,
          )
        ]));
  }
}
