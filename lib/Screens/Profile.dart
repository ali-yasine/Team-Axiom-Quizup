import 'package:quizup_prototype_1/Utilities/player.dart';
import 'package:flutter/material.dart';
import 'Home.dart';

class ProfilePage extends StatelessWidget {
  final Player player;
  const ProfilePage({Key? key, required this.player}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Profile(player: player));
  }
}

class Profile extends StatelessWidget {
  final Player player;
  const Profile({Key? key, required this.player}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(207, 232, 255, 20),
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: _width,
                height: 100,
                color: const Color.fromRGBO(51, 156, 254, 10),
                child: Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: const Text(
                    "User Profile",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                  width: _width,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(51, 156, 254, 10),
                    border: Border.all(
                      color: const Color.fromRGBO(51, 156, 254, 10),
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(children: [
                    Row(children: [
                      Container(
                        width: 115,
                        height: 115,
                        margin: const EdgeInsets.only(left: 140.0),
                        child: const CircleAvatar(
                          child: CircleAvatar(
                            radius: 57.5,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                          ),
                        ),
                      ),
                    ]),
                  ])),
              const SizedBox(
                height: 10,
              ),
              Column(children: <Widget>[
                Text(player.username,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(51, 156, 254, 10),
                    ),
                    textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  width: _width - 15,
                  margin: const EdgeInsets.only(right: 5.0, left: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromRGBO(51, 156, 254, 10),
                        width: 2,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: Text(
                    player.email,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 25),
                    width: 100,
                    height: 38,
                    child: const Center(
                        child: Text(
                      " Email Address",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(51, 156, 254, 10),
                          fontWeight: FontWeight.bold),
                    ))),
                Row(children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5.0, left: 10.0),
                    width: _width / 3 - 20,
                    height: _width / 3 - 20,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(51, 156, 254, 10),
                          width: 2,
                        ),
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25))),
                    child: Text(
                        (player.gamesWon / player.gamesPlayed).toString(),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5.0, left: 5.0),
                    width: _width / 3 - 20,
                    height: _width / 3 - 20,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(51, 156, 254, 10),
                          width: 2,
                        ),
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25))),
                    child: Text(player.gamesPlayed.toString(),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5.0, left: 5.0),
                    width: _width / 3 - 20,
                    height: _width / 3 - 20,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(51, 156, 254, 10),
                          width: 2,
                        ),
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25))),
                    child: Text(player.rankByCountry.toString(),
                        textAlign: TextAlign.center),
                  ),
                ]),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 25),
                        width: 80,
                        height: 38,
                        child: const Center(
                            child: Text(
                          " Win rate",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(51, 156, 254, 10),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ))),
                    Container(
                        margin: const EdgeInsets.only(left: 50),
                        width: 80,
                        height: 38,
                        child: const Center(
                            child: Text(
                          " Global Rank",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(51, 156, 254, 10),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ))),
                    Container(
                        margin: const EdgeInsets.only(left: 50),
                        width: 80,
                        height: 38,
                        child: const Center(
                            child: Text(
                          "Rank By Country",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(51, 156, 254, 10),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ))),
                  ],
                ),
                const SizedBox(height: 10),
                Row(children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5.0, left: 10.0),
                    width: _width / 3 - 20,
                    height: _width / 3 - 20,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(51, 156, 254, 10),
                          width: 2,
                        ),
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25))),
                    child: Text(player.gamesPlayed.toString(),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5.0, left: 5.0),
                    width: _width / 3 - 20,
                    height: _width / 3 - 20,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(51, 156, 254, 10),
                          width: 2,
                        ),
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25))),
                    child: Text(player.gamesWon.toString(),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5.0, left: 5.0),
                    width: _width / 3 - 20,
                    height: _width / 3 - 20,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(51, 156, 254, 10),
                          width: 2,
                        ),
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25))),
                    child: Text(player.avgSecondsToAnswer.toString(),
                        textAlign: TextAlign.center),
                  ),
                ]),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 25),
                        width: 80,
                        height: 38,
                        child: const Center(
                            child: Text(
                          " Games Played",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(51, 156, 254, 10),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ))),
                    Container(
                        margin: const EdgeInsets.only(left: 50),
                        width: 80,
                        height: 38,
                        child: const Center(
                            child: Text(
                          " Number Of Games Won",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(51, 156, 254, 10),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ))),
                    Container(
                        margin: const EdgeInsets.only(left: 50),
                        width: 80,
                        height: 38,
                        child: const Center(
                            child: Text(
                          "Average seconds to answer",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(51, 156, 254, 10),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ))),
                  ],
                ),
              ]),
              const SizedBox(height: 10),
              const SizedBox(
                height: 200,
              ),
              const SizedBox(
                height: 200,
              ),
              const SizedBox(
                height: 200,
              ),
            ],
          ),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(51, 156, 254, 10),
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomePage(player: player)));
              break;
            case 2:
              //TODO ADD LEADERBOARD TO NAVIGATOR
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomePage(player: player)));
              break;
            default:
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