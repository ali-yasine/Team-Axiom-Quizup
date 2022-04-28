// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Backend%20Management/fireConnect.dart';
import 'package:quizup_prototype_1/Screens/ChallengeAFriend.dart';
import 'package:quizup_prototype_1/Screens/MatchingPage.dart';
import 'package:quizup_prototype_1/Utilities/Rank.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import 'Home.dart';

class SubjectScreen extends StatefulWidget {
  final String subject;
  final Player player;
  const SubjectScreen({
    Key? key,
    required this.subject,
    required this.player,
  }) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  void play(BuildContext context) async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MatchingPge(
              subject: widget.subject,
              player: widget.player,
            )));
  }

  List<Rank> players = [];

  Future<void> getTopthree() async {
    var playerRanks = await FireConnect.getLeaderBoard(widget.subject);
    players = playerRanks.entries
        .map((entry) => Rank(
              username: entry.key,
              rankNumber: 0,
              country: entry.value[0],
              score: entry.value[1].toString(),
            ))
        .toList();
    players.sort((a, b) => a.score.compareTo(b.score));
    for (int i = 0; i < players.length; i++) {
      var rank = players[i];
      players[i] = Rank(
          country: rank.country,
          score: rank.score,
          username: rank.username,
          rankNumber: i + 1);
    }
    if (players.length < 3) {
      for (int i = players.length; i < 3; i++) {
        players.add(Rank(
          country: "",
          username: "",
          score: "",
          rankNumber: i + 1,
        ));
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    players = const [
      Rank(rankNumber: 1, username: "", score: "", country: ""),
      Rank(rankNumber: 2, username: "", score: "", country: ""),
      Rank(rankNumber: 3, username: "", score: "", country: "")
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getTopthree();
    double _width = MediaQuery.of(context).size.width;
    const img = AssetImage('assets/images/panda.jpg');

    const _profileRadius = 35.0;
    const _iconSize = 40.0;
    const buttonColor = Color.fromRGBO(51, 156, 251, 0);

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
                    child: CircleAvatar(
                        child: CircleAvatar(
                          radius: _profileRadius - 2,
                          backgroundColor: Colors.grey,
                          child: widget.player.avatar,
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
              flex: 23),
          Flexible(
              flex: 2,
              child: Container(
                color: Colors.grey[300],
              )),
          Flexible(
              child: Container(
                width: _width - 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color.fromARGB(255, 13, 77, 174)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Text(
                  widget.subject,
                  style: const TextStyle(
                      fontSize: 26, color: Color.fromARGB(255, 13, 77, 174)),
                  textAlign: TextAlign.center,
                )),
              ),
              flex: 10),
          Flexible(
              flex: 2,
              child: Container(
                color: Colors.grey[300],
              )),
          Flexible(
              child: Container(
                width: 300,
                height: 250,
                decoration: BoxDecoration(
                    image: const DecorationImage(image: img, fit: BoxFit.fill),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 13, 77, 174),
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
              ),
              flex: 35),
          Flexible(
              child: Container(
                  alignment: Alignment.center,
                  child: const Text("Top players",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 13, 77, 174),
                          fontWeight: FontWeight.bold))),
              flex: 8),
          Flexible(
            child: players.first,
            flex: 10,
          ),
          Flexible(
            child: players[1],
            flex: 10,
          ),
          Flexible(
            child: players[2],
            flex: 10,
          ),
          Row(children: [
            const SizedBox(
              width: 10,
            ),
            Flexible(
                child: SizedBox(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: ElevatedButton(
                        onPressed: () => play(context),
                        child: const FittedBox(
                            child: Text(
                              "Play",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            fit: BoxFit.fill),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 13, 77, 174),
                        )),
                      )),
                  height: 75,
                  width: _width / 2,
                ),
                flex: 75),
            Flexible(
              child: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => ChallengeAFriend(
                                      subject: widget.subject,
                                      player: widget.player)))
                        },
                        child: const FittedBox(
                            child: Text(
                              "Challenge a Friend",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            fit: BoxFit.fill),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 13, 77, 174),
                        )),
                      )),
                  height: 75,
                  width: _width / 2,
                  margin: const EdgeInsets.all(30)),
              flex: 100,
            )
          ]),
        ]));
  }
}
