import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utilities/Rank.dart';
import '../Utilities/player.dart';
import 'Home.dart';
import 'Profile.dart';
import 'countries.dart';
import 'subjects.dart';

class GenericLeaderBoard extends StatefulWidget {
  final String title;
  final List<Rank> ranks;
  final Player player;
  const GenericLeaderBoard(
      {Key? key,
      required this.title,
      required this.player,
      required this.ranks})
      : super(key: key);

  @override
  State<GenericLeaderBoard> createState() => _GenericLeaderBoardState();
}

class _GenericLeaderBoardState extends State<GenericLeaderBoard> {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
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
                            backgroundColor: Colors.transparent,
                            child: widget.player.avatar,
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          margin:
                              const EdgeInsets.only(right: 15.0, left: 20.0),
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
                          fontSize: 26,
                          color: Color.fromARGB(255, 13, 77, 174)),
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
                                                  player: widget.player,
                                                )));
                                  },
                                  child: const Text(
                                    "By Subject",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  255, 13, 77, 174))),
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
                                                  player: widget.player,
                                                )));
                                  },
                                  child: const Text(
                                    "By Country",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  255, 13, 77, 174))),
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
                                  onPressed: () {},
                                  child: Text(
                                    widget.title,
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  255, 13, 77, 174))),
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
                      " Global Rank",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Color.fromARGB(255, 13, 77, 174)),
                      textAlign: TextAlign.center,
                    )),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: const [
                      Expanded(
                        flex: 3,
                        child: Text(
                          " Rank",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 13, 77, 174)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          " Username",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 13, 77, 174)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          " Score",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 13, 77, 174)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          " Country",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 13, 77, 174)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ] +
                widget.ranks,
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
                        player: widget.player,
                      )));
              break;
            case (1):
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomePage(
                        player: widget.player,
                      )));
              break;

            case (2):
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
