import 'package:quizup_prototype_1/Screens/Profile.dart';
import 'package:quizup_prototype_1/Screens/subjects.dart';

import '../Utilities/player.dart';
import 'Home.dart';

import 'package:flutter/material.dart';

import 'Leaderboard.dart';

class countries extends StatelessWidget {
  final Player player;
  const countries({Key? key, required this.player}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
          child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: _width,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 13, 77, 174),
                  border: Border.all(
                    color: const Color.fromARGB(255, 13, 77, 174),
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Row(children: [
                  Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.only(left: 5),
                    child: CircleAvatar(
                      child: CircleAvatar(
                        radius: 33,
                        backgroundColor: Colors.grey,
                        child: player.avatar,
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 15.0, left: 20.0),
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
                          //used to make circular borders
                          borderRadius: BorderRadius.circular(15),
                          child: const Center(
                              child: Text(
                            " username",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 13, 77, 174)),
                            textAlign: TextAlign.center,
                          )))),
                ]),
              ),
              Container(
                width: _width - 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                    child: Text(
                  " Leaderboard",
                  style: TextStyle(
                      fontSize: 26, color: Color.fromARGB(255, 13, 77, 174)),
                  textAlign: TextAlign.center,
                )),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                        margin: const EdgeInsets.only(right: 5, left: 5),
                        width: 115,
                        height: 80,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => Subjects(
                                              player: player,
                                            )));
                              },
                              child: const Text(
                                "By Subject",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 13, 77, 174))),
                            ))),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                        margin: const EdgeInsets.only(right: 5, left: 5),
                        width: 115,
                        height: 80,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => countries(
                                              player: player,
                                            )));
                              },
                              child: const Text(
                                "By Country",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 13, 77, 174))),
                            ))),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                        margin: const EdgeInsets.only(right: 5, left: 5),
                        width: 115,
                        height: 80,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => Leaderboard(
                                              player: player,
                                            )));
                              },
                              child: const Text(
                                "Global",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 13, 77, 174))),
                            ))),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: _width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color.fromARGB(255, 13, 77, 174),
                    width: 2,
                  ),
                ),
                child: const Center(
                    child: Text(
                  " Countries",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color.fromARGB(255, 13, 77, 174)),
                  textAlign: TextAlign.center,
                )),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: _width - 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                    child: Text(
                  " Lebanon",
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 13, 77, 174)),
                  textAlign: TextAlign.center,
                )),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: _width - 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                    child: Text(
                  " UAE",
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 13, 77, 174)),
                  textAlign: TextAlign.center,
                )),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: _width - 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                    child: Text(
                  " Brazil",
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 13, 77, 174)),
                  textAlign: TextAlign.center,
                )),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: _width - 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                    child: Text(
                  " Spain",
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 13, 77, 174)),
                  textAlign: TextAlign.center,
                )),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: _width - 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                    child: Text(
                  " Kuwait",
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 13, 77, 174)),
                  textAlign: TextAlign.center,
                )),
              ),
            ],
          ),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 13, 77, 174),
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: (index) {
          switch (index) {
            case (0):
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ProfilePage(
                        player: player,
                      )));
              break;
            case (1):
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomePage(
                        player: player,
                      )));
              break;

            case (2):
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => countries(
                        player: player,
                      )));
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(IconData(0xe491, fontFamily: 'MaterialIcons')),
              label: "profile"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(
              icon: Icon(IconData(0xe36f, fontFamily: 'MaterialIcons')),
              label: "leaderboard"),
        ],
      ),
    ));
  }
}
