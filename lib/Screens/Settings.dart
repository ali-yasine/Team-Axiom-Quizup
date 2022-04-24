import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Screens/Home.dart';
import '../Utilities/player.dart';
import '../Login-SignUp/Login.dart';

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
      username: "jd",
      avatar: const AssetImage("assets/images/panda.jpg"),
      gamesWon: 12,
      avgSecondsToAnswer: 1,
      rankByCountry: 1,
      rankGlobal: 1,
      gamesPlayed: 1);

  @override
  Widget build(BuildContext context) {
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
            const Text("Current password",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 13, 77, 174),
                ),
                textAlign: TextAlign.left),
            Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 13, 77, 174),
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: ClipRRect(
                  //used to make circular borders
                  borderRadius: BorderRadius.circular(30),
                  child: TextField(
                    obscureText: true,
                    controller: currentController,
                    decoration: const InputDecoration(),
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            const Text("New password",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 13, 77, 174),
                ),
                textAlign: TextAlign.left),
            Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 13, 77, 174),
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: ClipRRect(
                  //used to make circular borders
                  borderRadius: BorderRadius.circular(30),
                  child: TextField(
                    obscureText: true,
                    controller: newController,
                    decoration: const InputDecoration(),
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            const Text("Confirm new password",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 13, 77, 174),
                ),
                textAlign: TextAlign.left),
            Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 13, 77, 174),
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: ClipRRect(
                  //used to make circular borders
                  borderRadius: BorderRadius.circular(30),
                  child: TextField(
                    obscureText: true,
                    controller: confirmController,
                    decoration: const InputDecoration(),
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 100,
                height: 50,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: ElevatedButton(
                      onPressed: () {
                        if (newController.text == confirmController.text &&
                            newController.text != "") {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(player: player)));
                        } else {
                          const Text(
                            "The passwords don't match",
                            style: TextStyle(
                                fontSize: 13, color: Colors.redAccent),
                            textAlign: TextAlign.center,
                          );
                        }
                      },
                      child: const Text(
                        "Change password",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 13, 77, 174))),
                    ))),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 100,
                height: 50,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>Login()));
                      },
                      child: const Text(
                        "Sign Out",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 13, 77, 174))),
                    )))

          ],
        ));
  }
}
