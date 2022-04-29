import 'package:quizup_prototype_1/Screens/Profile.dart';
import 'package:quizup_prototype_1/Screens/subjects.dart';

import '../Backend Management/fireConnect.dart';
import '../Utilities/Rank.dart';
import '../Utilities/player.dart';
import 'GenericLeaderBoard.dart';
import 'Home.dart';

import 'package:flutter/material.dart';

import 'Leaderboard.dart';

class countries extends StatefulWidget {
  final Player player;
  const countries({Key? key, required this.player}) : super(key: key);

  @override
  State<countries> createState() => _countriesState();
}

class _countriesState extends State<countries> {
  late List<Widget> _countries;
  bool loaded = false;
  List<Widget> getList() => loaded ? _countries : <Widget>[Container()];

  Future getCountryNames(BuildContext context) async {
    var countrynames = await FireConnect.getCountries();
    var _width = MediaQuery.of(context).size.width;
    _countries = countrynames
        .map((e) => GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  width: _width - 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Text(
                    e,
                    style: const TextStyle(
                        fontSize: 16, color: Color.fromARGB(255, 13, 77, 174)),
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
              onTap: () async {
                var playerMap = await FireConnect.getCountryLeaderBoard(e);
                var ranks = playerMap.entries
                    .map((e) => Rank(
                        rankNumber: 0,
                        username: e.key,
                        score: e.value[1].toString(),
                        country: e.value[0]))
                    .toList();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GenericLeaderBoard(
                        title: e, player: widget.player, ranks: ranks)));
              },
            ))
        .toList();
    setState(() {
      loaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCountryNames(context);
    double _width = MediaQuery.of(context).size.width;
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
                        child: CircleAvatar(
                          child: CircleAvatar(
                            radius: 33,
                            backgroundColor: Colors.grey,
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
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                            builder: (context) => Leaderboard(
                                                  player: widget.player,
                                                )));
                                  },
                                  child: const Text(
                                    "Global",
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
                ] +
                getList(),
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Leaderboard(
                        player: widget.player,
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
    );
  }
}
