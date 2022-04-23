import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Screens/MatchingPage.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import 'Home.dart';

class SubjectScreen extends StatelessWidget {
  final String subject;
  final Player player;
  const SubjectScreen({
    Key? key,
    required this.subject,
    required this.player,
  }) : super(key: key);
  void play(BuildContext context) async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MatchingPge(
              subject: subject,
              player: player,
            )));
  }

  @override
  Widget build(BuildContext context) {
    const img = AssetImage('assets/images/panda.jpg');
    const backgroundColor = Color.fromRGBO(207, 232, 255, 20);
    const _profileRadius = 35.0;
    const _iconSize = 40.0;
    const buttonColor = Color.fromRGBO(51, 156, 251, 0);

    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(children: [
          Flexible(
              child: Container(
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
                          color: const Color.fromRGBO(51, 156, 254, 10),
                          width: 1,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25))),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Center(
                            child: FittedBox(
                                child: Text(
                                  player.username,
                                  style: const TextStyle(
                                      color: Color.fromRGBO(51, 156, 254, 10)),
                                  textAlign: TextAlign.center,
                                ),
                                fit: BoxFit.cover)))),
              ]),
              flex: 23),
          Flexible(
              child: Container(
                  alignment: Alignment.center,
                  child: Text(subject,
                      style: const TextStyle(
                          fontSize: 45,
                          color: Color.fromRGBO(51, 156, 254, 10),
                          fontWeight: FontWeight.bold))),
              flex: 23),
          Flexible(
              child: Container(
                width: 300,
                height: 250,
                decoration: BoxDecoration(
                    image: const DecorationImage(image: img, fit: BoxFit.fill),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromRGBO(51, 156, 254, 10),
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
              ),
              flex: 75),
          Flexible(
              child: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: ElevatedButton(
                        onPressed: () => play(context),
                        child: const FittedBox(
                            child: Text(
                              "Play",
                              style:
                                  TextStyle(fontSize: 45, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            fit: BoxFit.fill),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(buttonColor)),
                      )),
                  width: 250,
                  height: 75,
                  margin: const EdgeInsets.only(top: 50)),
              flex: 40),
          Flexible(
            child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: ElevatedButton(
                      onPressed: () => {},
                      child: const FittedBox(
                          child: Text(
                            "Challenge a Friend",
                            style: TextStyle(fontSize: 45, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          fit: BoxFit.fill),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(buttonColor)),
                    )),
                width: 250,
                height: 75,
                margin: const EdgeInsets.all(30)),
            flex: 40,
          )
        ]));
  }
}
