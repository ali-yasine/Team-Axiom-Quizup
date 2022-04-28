import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import '../Backend Management/fireConnect.dart';
import '../Quiz components/quiz.dart';
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            flex: 20),
        Flexible(
            flex: 5,
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
              child: const Center(
                  child: Text(
                " Join A Room",
                style: TextStyle(
                    fontSize: 26, color: Color.fromARGB(255, 13, 77, 174)),
                textAlign: TextAlign.center,
              )),
            ),
            flex: 5),
        Flexible(
            flex: 4,
            child: Container(
              color: Colors.grey[300],
            )),
        Flexible(
            child: Row(children: [
              Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.grey[300],
                  )),
              Flexible(
                flex: 30,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color.fromARGB(255, 13, 77, 174),
                          width: 2,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25))),
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
              Flexible(
                  flex: 2,
                  child: Container(
                    color: Colors.grey[300],
                  )),
            ]),
            flex: 3),
        Flexible(
            flex: 2,
            child: Container(
              color: Colors.grey[300],
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
                      child: SizedBox(
                        height: 50,
                        width: _width / 2,
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
            flex: 3,
            child: Container(
              color: Colors.grey[300],
            )),
      ]),
    );
  }
}
