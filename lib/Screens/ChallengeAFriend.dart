import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Screens/JoinARoom.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import 'Home.dart';
import 'CreateARoom.dart';

class ChallengeAFriend extends StatelessWidget {
  final String subject;
  final Player player;
  const ChallengeAFriend({
    Key? key,
    required this.subject,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    const _profileRadius = 35.0;
    const _iconSize = 40.0;

    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                  child: CircleAvatar(
                      child: CircleAvatar(
                        radius: _profileRadius - 2,
                        backgroundColor: Colors.grey,
                        child: player.avatar,
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
                                player.username,
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
                border: Border.all(color: Color.fromARGB(255, 13, 77, 174)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                  child: Text(
                " Challenge A Friend",
                style: TextStyle(
                    fontSize: 26, color: Color.fromARGB(255, 13, 77, 174)),
                textAlign: TextAlign.center,
              )),
            ),
            flex: 9),
        Flexible(
            flex: 5,
            child: Container(
              color: Colors.grey[300],
            )),
        Flexible(
            child: Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => CreateARoom(
                                  player: player,
                                  subject: subject,
                                ))),
                    child: const FittedBox(
                        child: Text(
                          "Create Room",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        fit: BoxFit.fill),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 13, 77, 174),
                    )),
                  )),
              height: 75,
              width: _width / 2 + 60,
            ),
            flex: 30),
        Flexible(
          child: Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => JoinARoom(
                                  player: player,
                                  subject: subject,
                                ))),
                    child: const FittedBox(
                        child: Text(
                          "Join a Room",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        fit: BoxFit.fill),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 13, 77, 174),
                    )),
                  )),
              height: 75,
              width: _width / 2 + 60,
              margin: const EdgeInsets.all(30)),
          flex: 30,
        )
      ]),
    );
  }
}
