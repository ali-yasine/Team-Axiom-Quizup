import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizup_prototype_1/Screens/MatchingPage.dart';
import 'package:quizup_prototype_1/Utilities/Rank.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import 'Home.dart';

class JoinARoom extends StatelessWidget {
  final String subject;
  final Player player;
  const JoinARoom({
    Key? key,
    required this.subject,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    const img = AssetImage('assets/images/panda.jpg');
    TextEditingController IDController = TextEditingController();
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
                        controller: IDController,
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
            flex: 4,
            child: Row(
              children: [
                Flexible(
                    flex: 10,
                    child: Center(
                      child: Container(
                        height: 50,
                        width: _width / 2,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: ElevatedButton(
                              onPressed: () => {},
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
