// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../Backend Management/fireConnect.dart';
import '../Utilities/Rank.dart';
import '../Utilities/player.dart';
import 'ChallengeAFriend.dart';
import 'Home.dart';
import 'MatchingPage.dart';

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
  void play(BuildContext context) {
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
    players.sort((b, a) => a.score.compareTo(b.score));
    for (int i = 0; i < players.length; i++) {
      var rank = players[i];
      players[i] = Rank(
          country: rank.country,
          score: rank.score,
          username: rank.username,
          rankNumber: i + 1);
    }
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
    }
    if (mounted) {
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
    Color blue = const Color.fromARGB(255, 13, 77, 174);
    getTopthree();
    final subjectImage = AssetImage('assets/images/${widget.subject}.jpeg');
    double _width = MediaQuery.of(context).size.width;
    const _profileRadius = 35.0;
    const _iconSize = 40.0;
    const buttonColor = Color.fromRGBO(51, 156, 251, 0);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          Flexible(
              child: Container(
                width: _width,
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
                    child: ClipOval(
                      child: widget.player.avatar,
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 15),
                      width: 150,
                      height: 30,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Center(
                              child: FittedBox(
                                  child: Text(
                                    widget.player.username,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  fit: BoxFit.cover)))),
                ]),
              ),
              flex: 23),
          Flexible(
              flex: 2,
              child: Container(
                color: Colors.white,
              )),
          Flexible(
              child: Container(
                width: _width - 20,
                child: Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12)),
                      depth: 30,
                      lightSource: LightSource.bottom,
                      color: Color.fromARGB(255, 232, 229, 229)),
                  child: Center(
                      child: Text(
                    widget.subject,
                    style: const TextStyle(fontSize: 26, color: Colors.black),
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
              flex: 10),
          Flexible(
              flex: 2,
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
                    border: Border.all(
                      color: Colors.black,
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
                          color: Colors.black,
                          fontWeight: FontWeight.bold))),
              flex: 8),
          Flexible(
            child: players.first,
            flex: 14,
          ),
          Flexible(
            child: players[1],
            flex: 14,
          ),
          Flexible(
            child: players[2],
            flex: 14,
          ),
          Row(children: [
            const SizedBox(
              width: 10,
            ),
            Flexible(
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
                          blue,
                        )),
                      )),
                  height: 75,
                  width: _width / 2,
                ),
                flex: 75),
            Flexible(
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
                        onPressed: () => {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => ChallengeAFriend(
                                      subject: widget.subject,
                                      player: widget.player)))
                        },
                        child: Container(
                          child: const Text(
                            "Challenge a Friend",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                          blue,
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
