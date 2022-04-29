import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:quizup_prototype_1/Screens/Home.dart';

import '../Login-Signup/Login.dart';
import '../Screens/Home.dart';
import '../Utilities/player.dart';

class SettingsPage extends StatelessWidget {
  final Player player;
  const SettingsPage({Key? key, required this.player}) : super(key: key);
  static const _iconSize = 40.0;
  @override
  Widget build(BuildContext context) {
    Color blue = Color.fromARGB(255, 13, 77, 174);
    double _width = MediaQuery.of(context).size.width;
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
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
                          color: Colors.black,
                        ),
                        iconSize: _iconSize,
                      ),
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.all(10),
                    )),
                    Flexible(
                        child: Container(
                          width: _width,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                blue,
                                const Color.fromARGB(255, 159, 31, 31),
                              ],
                            ),
                          ),
                          child: const Center(
                              child: Text(
                            "Settings",
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                        ),
                        flex: 10),
                    Flexible(
                        flex: 2,
                        child: Container(
                          height: 10,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 115,
                      height: 115,
                      child: CircleAvatar(
                        radius: 57.5,
                        backgroundColor: Colors.grey,
                        child: ClipOval(
                          child: player.avatar,
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
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20.0,
                                color: Color.fromARGB(255, 125, 125, 125),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
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
                      child: Container(
                          width: _width - 30,
                          height: 50,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20.0,
                                color: Color.fromARGB(255, 125, 125, 125),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
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
