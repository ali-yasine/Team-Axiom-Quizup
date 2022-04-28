import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Screens/Home.dart';

import '../Login-Signup/Login.dart';
import '../Screens/Home.dart';
import '../Utilities/player.dart';

class Settings extends StatelessWidget {
  final Player player;
  const Settings({Key? key, required this.player}) : super(key: key);
  static const _iconSize = 40.0;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.grey[300],
            body: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Flexible(
                        child: Container(
                      child: IconButton(
                        onPressed: () => Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
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
                    SizedBox(
                      width: 115,
                      height: 115,
                      child: CircleAvatar(
                        radius: 57.5,
                        backgroundColor: Colors.grey,
                        child: ClipOval(child: player.avatar),
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
                      child: SizedBox(
                          width: _width - 30,
                          height: 50,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: ElevatedButton(
                                onPressed: () => Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) =>
                                            HomePage(player: player))),
                                child: const Text(
                                  "Change password",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 13, 77, 174))),
                              ))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      flex: 4,
                      child: SizedBox(
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
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 13, 77, 174))),
                              ))),
                    ),
                  ],
                ))));
  }
}
