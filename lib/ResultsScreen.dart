import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/main.dart';
import 'package:quizup_prototype_1/player.dart';

class results extends StatelessWidget {
  final Player player;
  final int score;
  final String subject;
  final int correct;
  final int incorrect;
  final int opponentScore;
  const results(
      {Key? key,
      required this.player,
      required this.score,
      required this.subject,
      required this.correct,
      required this.incorrect,
      required this.opponentScore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(207, 232, 255, 20),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Container(
              alignment: Alignment.center,
              child: Text(subject,
                  style: const TextStyle(
                      fontSize: 35,
                      color: Color.fromRGBO(51, 156, 254, 10),
                      fontWeight: FontWeight.bold))),
          const SizedBox(height: 30),
          Container(
              width: 300,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color.fromRGBO(51, 156, 254, 10),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: ClipRRect(
                  //used to make circular borders
                  borderRadius: BorderRadius.circular(15),
                  child: Center(
                      child: Text(
                    subject,
                    style: const TextStyle(
                        fontSize: 26, color: Color.fromRGBO(51, 156, 254, 10)),
                    textAlign: TextAlign.center,
                  )))),
          const SizedBox(height: 20),
          Container(
              margin: const EdgeInsets.only(left: 30.0),
              alignment: Alignment.centerLeft,
              child: Text("Player ",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(51, 156, 254, 10)))),
          const SizedBox(height: 20),
          Row(children: [
            Container(
                margin: const EdgeInsets.only(right: 15.0, left: 135.0),
                width: 250,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromRGBO(51, 156, 254, 10),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: ClipRRect(
                    //used to make circular borders
                    borderRadius: BorderRadius.circular(15),
                    child: Center(
                        child: Text(
                      player.username,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(51, 156, 254, 10)),
                      textAlign: TextAlign.center,
                    ))))
          ]),
          const SizedBox(height: 10),
          Row(children: [
            Container(
                margin: const EdgeInsets.only(left: 135.0),
                width: 80,
                height: 38,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromRGBO(51, 156, 254, 10),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: ClipRRect(
                    //used to make circular borders
                    borderRadius: BorderRadius.circular(15),
                    child: Center(
                        child: Text(
                      score.toString(),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(51, 156, 254, 10)),
                      textAlign: TextAlign.center,
                    )))),
            Container(
                margin: const EdgeInsets.only(left: 5.0),
                width: 80,
                height: 38,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromRGBO(51, 156, 254, 10),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: ClipRRect(
                    //used to make circular borders
                    borderRadius: BorderRadius.circular(15),
                    child: Center(
                        child: Text(
                      correct.toString(),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(51, 156, 254, 10)),
                      textAlign: TextAlign.center,
                    )))),
            Container(
                margin: const EdgeInsets.only(left: 5.0),
                width: 80,
                height: 38,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromRGBO(51, 156, 254, 10),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: ClipRRect(
                    //used to make circular borders
                    borderRadius: BorderRadius.circular(15),
                    child: Center(
                        child: Text(
                      incorrect.toString(),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(51, 156, 254, 10)),
                      textAlign: TextAlign.center,
                    )))),
          ]),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 135.0),
                  width: 80,
                  height: 38,
                  child: Center(
                      child: Text(
                    "score",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(51, 156, 254, 10),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ))),
              Container(
                  margin: const EdgeInsets.only(left: 2.5),
                  width: 80,
                  height: 38,
                  child: Center(
                      child: Text(
                    " correct answer",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(51, 156, 254, 10),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ))),
              Container(
                  margin: const EdgeInsets.only(left: 2.5),
                  width: 80,
                  height: 38,
                  child: Center(
                      child: Text(
                    "incorrect answer",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(51, 156, 254, 10),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ))),
            ],
          ),
          (score > opponentScore)
              ? Container(
                  width: 300,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(
                        color: Color.fromRGBO(51, 156, 254, 10),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: ClipRRect(
                      //used to make circular borders
                      borderRadius: BorderRadius.circular(15),
                      child: const Center(
                          child: Text(
                        "Congradulations! You won",
                        style: TextStyle(fontSize: 26, color: Colors.white),
                        textAlign: TextAlign.center,
                      ))))
              : Container(
                  width: 300,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(
                        color: const Color.fromRGBO(51, 156, 254, 10),
                        width: 2,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: ClipRRect(
                      //used to make circular borders
                      borderRadius: BorderRadius.circular(15),
                      child: const Center(
                          child: Text(
                        "Sorry, you lost",
                        style: TextStyle(fontSize: 26, color: Colors.white),
                        textAlign: TextAlign.center,
                      )))),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 30.0),
                  width: 100,
                  height: 50,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const HomePage())),
                        child: const Text(
                          "Leaderboard",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(17, 98, 173, 100))),
                      ))),
              Container(
                  margin: const EdgeInsets.only(left: 25.0),
                  width: 100,
                  height: 50,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const HomePage())),
                        child: const Text(
                          "Home",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(17, 98, 173, 100))),
                      ))),
              Container(
                  margin: const EdgeInsets.only(left: 25.0),
                  width: 100,
                  height: 50,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const HomePage())),
                        child: const Text(
                          "Play again",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(17, 98, 173, 100))),
                      )))
            ],
          ),
        ],
      ),
    );
  }
}
