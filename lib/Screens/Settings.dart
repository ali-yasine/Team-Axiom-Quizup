import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Screens/Home.dart';

import '../Login-Signup/Login.dart';
import '../Screens/Home.dart';
import '../Utilities/player.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController currentController = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  static const _iconSize = 40.0;
  final img = const AssetImage("assets/images/panda.jpg");
  var player = Player(
      email: 'ud',
      country: 'Lebanon',
      username: "jd",
      avatar: const AssetImage("assets/images/panda.jpg"),
      gamesWon: 12,
      avgSecondsToAnswer: 1,
      gamesPlayed: 1);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
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
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Settings',
                  style: TextStyle(
                    color: Color.fromARGB(255, 13, 77, 174),
                    fontWeight: FontWeight.bold,
                    fontSize: 34,
                  ),
                )),
            Container(
              width: 115,
              height: 115,
              child: const CircleAvatar(
                child: CircleAvatar(
                  radius: 57.5,
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Change photo",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 13, 77, 174),
                ),
                textAlign: TextAlign.center),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              flex: 4,
              child: Container(
                  width: _width - 30,
                  height: 50,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomePage(player: player))),
                        child: const Text(
                          "Change password",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 13, 77, 174))),
                      ))),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 4,
              child: Container(
                  width: _width - 30,
                  height: 50,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        child: const Text(
                          "Sign out",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 13, 77, 174))),
                      ))),
            ),
          ],
        ));
  }
}
