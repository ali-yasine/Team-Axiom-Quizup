import 'package:quizup_prototype_1/Screens/Leaderboard.dart';
import 'package:quizup_prototype_1/Screens/Profile.dart';

import '../Utilities/player.dart';
import 'Home.dart';
import 'countries.dart';

import 'package:flutter/material.dart';

class subjects extends StatelessWidget {
  const subjects({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _subjects());
  }
}

class _subjects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var player = Player(
        email: 'ud',
        username: "jd",
        avatar: const AssetImage("assets/images/panda.jpg"),
        gamesWon: 12,
        avgSecondsToAnswer: 1,
        rankByCountry: 1,
        rankGlobal: 1,
        gamesPlayed: 1);
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                    child: const CircleAvatar(
                      child: CircleAvatar(
                        radius: 33,
                        backgroundColor: Colors.grey,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
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
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const subjects()));
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
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const countries()));
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
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Leaderboard()));
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
                  " Subjects",
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
                  " Natural Science",
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
                  " Sports",
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
                  " History",
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
                  " Movies",
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
                  " Tv Series",
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
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const subjects()));
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
    );
  }
}