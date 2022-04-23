import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizup_prototype_1/Screens/MatchingPage.dart';
import 'package:quizup_prototype_1/Utilities/Rank.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import 'Home.dart';

class CreateARoom extends StatelessWidget {
  final String subject;
  final Player player;
  const CreateARoom({
    Key? key,
    required this.subject,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    const img = AssetImage('assets/images/panda.jpg');
    const token = "100323";
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
                " Create A Room",
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
                flex: 20,
                child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 15),
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
                        child: const Center(
                            child: FittedBox(
                                child: Text(
                                  token,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 13, 77, 174)),
                                  textAlign: TextAlign.center,
                                ),
                                fit: BoxFit.cover)))),
              ),
              Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.grey[300],
                  )),
              Flexible(
                child: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: ElevatedButton(
                        onPressed: () =>
                            {Clipboard.setData(ClipboardData(text: token))},
                        child: const FittedBox(
                            child: Text(
                              "copy",
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
                ),
                flex: 8,
              )
            ]),
            flex: 2),
        Flexible(
            flex: 5,
            child: Container(
              color: Colors.grey[300],
            )),
        Center(
          child: Container(
              padding: const EdgeInsets.all(0.0),
              alignment: Alignment.center,
              child: const Text("Please wait for your friend to join",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 24, color: Color.fromARGB(255, 28, 109, 175)))),
        ),
        Flexible(
            flex: 1,
            child: Container(
              color: Colors.grey[300],
            )),
        const CircularProgressIndicator(),
      ]),
    );
  }
}
