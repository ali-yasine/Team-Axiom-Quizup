import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/player.dart';
import 'package:quizup_prototype_1/subject_screen.dart';

import 'ResultsScreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _home());
  }
}

class _home extends StatelessWidget {
  Player player = Player(username: "user", id: "123");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(207, 232, 255, 20),
      appBar: AppBar(
        title: const Text('Subjects',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        titleTextStyle: const TextStyle(fontStyle: FontStyle.italic),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 52, 80, 92),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Icon(Icons.airline_seat_recline_normal_outlined,
                  color: Color.fromRGBO(51, 156, 244, 100)),
              const Text("player"),
            ]),
            SizedBox(
              width: 500,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(51, 156, 244, 100),
                      textStyle: const TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => subjectScreen(
                              subject: "Natural science",
                              player: player,
                            )));
                  },
                  child: const Text('Natural Science')),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 500,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(51, 156, 244, 100),
                      textStyle: const TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => subjectScreen(
                              subject: "Sports",
                              player: player,
                            )));
                  },
                  child: const Text('Sports')),
            ),
          ],
        ),
      ),
    );
  }
}
