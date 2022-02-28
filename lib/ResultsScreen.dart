import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/main.dart';
import 'package:quizup_prototype_1/player.dart';

class results extends StatelessWidget {
  final Player player;
  final int score;
  final String subject;
  const results(
      {Key? key,
      required this.player,
      required this.score,
      required this.subject})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          subject,
          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
              child: const Text(
                "Results: ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 30)),
          Text(player.username + "\n\n" + " score: " + score.toString(),
              textAlign: TextAlign.left, style: const TextStyle(fontSize: 28)),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePage())),
            child: const Text("Home"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue[400])),
          )
        ],
      ),
    );
  }
}
