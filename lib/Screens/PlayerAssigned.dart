import 'package:flutter/material.dart';

import 'package:quizup_prototype_1/Utilities/player.dart';
import 'Home.dart';

class PlayerAssigned extends StatelessWidget {
  final String subject;
  final Player player1;
  final Player player2;
  const PlayerAssigned({
    Key? key,
    required this.subject,
    required this.player1,
    required this.player2,
  }) : super(key: key);
//TODO FIX
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    const img = AssetImage('assets/images/panda.jpg');
    const _profileRadius = 50.0;
    const _iconSize = 40.0;
    const buttonColor = Color.fromRGBO(51, 156, 251, 0);

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(
              child: Container(
            child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomePage(
                            player: player1,
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
              child: Container(
                  alignment: Alignment.center,
                  child: Text(subject,
                      style: const TextStyle(
                          fontSize: 45,
                          color: Color.fromARGB(255, 13, 77, 174),
                          fontWeight: FontWeight.bold))),
              flex: 3),
          Flexible(
              child: Container(
                width: 300,
                height: 250,
                decoration: BoxDecoration(
                    image: const DecorationImage(image: img, fit: BoxFit.fill),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 13, 77, 174),
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
              ),
              flex: 5),
          Flexible(
              flex: 1,
              child: Container(
                color: Colors.grey[300],
              )),
          Flexible(
              flex: 7,
              child: Container(
                  width: _width - 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 13, 77, 174),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Flexible(
                      flex: 50,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                                flex: 15,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      flex: 30,
                                      child: Container(
                                        child: const CircleAvatar(
                                            child: CircleAvatar(
                                              radius: _profileRadius - 2,
                                              backgroundColor: Colors.grey,
                                              backgroundImage: img,
                                            ),
                                            radius: _profileRadius),
                                      ),
                                    ),
                                    Flexible(
                                        child: Container(
                                            alignment: Alignment.center,
                                            child: const Text("vs",
                                                style: TextStyle(
                                                    fontSize: 45,
                                                    color: Color.fromARGB(
                                                        255, 13, 77, 174),
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        flex: 50),
                                    Flexible(
                                      flex: 40,
                                      child: Container(
                                        child: const CircleAvatar(
                                            child: CircleAvatar(
                                              radius: _profileRadius - 2,
                                              backgroundColor: Colors.grey,
                                              backgroundImage: img,
                                            ),
                                            radius: _profileRadius),
                                      ),
                                    )
                                  ],
                                )),
                            Flexible(
                                flex: 1, child: Container(color: Colors.white)),
                            Flexible(
                                flex: 5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 30,
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          width: 150,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 13, 77, 174),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(25))),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Center(
                                                  child: FittedBox(
                                                      child: Text(
                                                        player1.username,
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    13,
                                                                    77,
                                                                    174)),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      fit: BoxFit.cover)))),
                                    ),
                                    Flexible(
                                      flex: 30,
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          width: 150,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 13, 77, 174),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(25))),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Center(
                                                  child: FittedBox(
                                                      child: Text(
                                                        player2.username,
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    13,
                                                                    77,
                                                                    174)),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      fit: BoxFit.cover)))),
                                    )
                                  ],
                                )),
                            Flexible(
                                flex: 1,
                                child: Container(
                                  color: Colors.white,
                                )),
                            Flexible(
                                flex: 5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 20,
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          width: 100,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 13, 77, 174),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(25))),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: const Center(
                                                  child: FittedBox(
                                                      child: Text(
                                                        "Rank : 7",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    13,
                                                                    77,
                                                                    174)),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      fit: BoxFit.cover)))),
                                    ),
                                    Flexible(
                                      flex: 20,
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          width: 100,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 13, 77, 174),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(25))),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: const Center(
                                                  child: FittedBox(
                                                      child: Text(
                                                        "Rank : 10",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    13,
                                                                    77,
                                                                    174)),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      fit: BoxFit.cover)))),
                                    )
                                  ],
                                ))
                          ])))),
          Flexible(
              flex: 1,
              child: Container(
                color: Colors.grey[300],
              )),
          Flexible(
              flex: 4,
              child: Container(
                child: Text(
                  "Player Assigned!",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.green[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
        ]));
  }
}
