import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../Backend Management/fireConnect.dart';
import '../Quiz components/quiz.dart';
import '../Utilities/player.dart';
import '../Utilities/question_template.dart';
import 'Home.dart';

class JoinARoom extends StatefulWidget {
  final String subject;
  final Player player;
  const JoinARoom({
    Key? key,
    required this.subject,
    required this.player,
  }) : super(key: key);

  @override
  State<JoinARoom> createState() => _JoinARoomState();
}

class _JoinARoomState extends State<JoinARoom> {
  TextEditingController idController = TextEditingController();
  bool attemptedToFind = false;
  bool roomFound = false;
  Future<void> findRoom(String roomID, BuildContext context) async {
    var challenge = await FirebaseFirestore.instance
        .collection('Challenges')
        .doc(roomID)
        .get();
    if (!challenge.exists) {
      setState(() {
        attemptedToFind = true;
      });
    } else {
      roomFound = true;
      await challenge.reference.update({"Player2": widget.player.username});
      Player opponent =
          await FireConnect.getPlayer(challenge.data()!["Player1"]);
      List<QuestionTemplate> questions = challenge
          .data()!["Questions"]
          .map<QuestionTemplate>((e) => QuestionTemplate.fromJson(e))
          .toList();
      String subject = questions.first.subject;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Quiz(
              opponent: opponent,
              isChallenge: true,
              questionTemplates: questions,
              player: widget.player,
              gameID: roomID,
              playerNum: 2,
              subject: subject)));
    }
  }

  Widget getRoomNotFoundWidget() {
    if (attemptedToFind && !roomFound) {
      return const Text(
        "Room not found",
        style: TextStyle(fontSize: 28),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    const _profileRadius = 35.0;
    const _iconSize = 40.0;
    Color blue = const Color.fromARGB(255, 13, 77, 174);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(children: [
        Flexible(
            child: Container(
              width: _width,
              height: 120,
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
                  child: CircleAvatar(
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.transparent,
                      child: widget.player.avatar,
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    width: 150,
                    height: 30,
                    color: Colors.transparent,
                    child: ClipRRect(
                        //used to make circular borders
                        borderRadius: BorderRadius.circular(15),
                        child: Center(
                            child: Text(
                          widget.player.username,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )))),
              ]),
            ),
            flex: 20),
        Flexible(
            flex: 5,
            child: Container(
              color: Colors.white,
            )),
        Flexible(
            child: Container(
              width: _width - 20,
              child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    depth: 30,
                    lightSource: LightSource.bottom,
                    color: Color.fromARGB(255, 232, 229, 229)),
                child: const Center(
                    child: Text(
                  "Join A Room",
                  style: TextStyle(fontSize: 26, color: Colors.black),
                  textAlign: TextAlign.center,
                )),
              ),
            ),
            flex: 5),
        Flexible(
            flex: 5,
            child: Container(
              color: Colors.white,
            )),
        Flexible(
            child: Row(children: [
              Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                  )),
              Flexible(
                flex: 30,
                child: Container(
                  child: Neumorphic(
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                          depth: 30,
                          lightSource: LightSource.top,
                          color: Color.fromARGB(255, 232, 229, 229)),
                      child: ClipRRect(
                        //used to make circular borders
                        borderRadius: BorderRadius.circular(30),
                        child: TextField(
                          controller: idController,
                          decoration: const InputDecoration(
                            labelText: '  Enter the room ID',
                          ),
                        ),
                      )),
                ),
              ),
              Flexible(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                  )),
            ]),
            flex: 3),
        Flexible(
            flex: 2,
            child: Container(
              color: Colors.white,
            )),
        Flexible(
          child: getRoomNotFoundWidget(),
          fit: FlexFit.tight,
          flex: 2,
        ),
        Flexible(
            flex: 4,
            child: Row(
              children: [
                Flexible(
                    flex: 10,
                    child: Center(
                      child: Container(
                        height: 50,
                        width: _width / 2,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20.0,
                              color: Color.fromARGB(255, 125, 125, 125),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: ElevatedButton(
                              onPressed: () =>
                                  findRoom(idController.text, context),
                              child: const Text(
                                "Join",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 13, 77, 174),
                              )),
                            )),
                      ),
                    )),
              ],
            )),
        Flexible(
            flex: 2,
            child: Container(
              color: Colors.white,
            )),
      ]),
    );
  }
}
