import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/material.dart';
import 'package:quizup/Screens/subjects.dart';
import '../Backend Management/fireConnect.dart';
import '../Utilities/Rank.dart';
import '../Utilities/player.dart';
import 'Home.dart';
import 'Profile.dart';
import 'countries.dart';

class Leaderboard extends StatefulWidget {
  Player player;
  Leaderboard({Key? key, required this.player}) : super(key: key);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  late List<Rank> players;
  bool loaded = false;
  Future<void> getPlayers() async {
    var playerMap = await FireConnect.getGlobalLeaderBoard();
    players = playerMap.entries
        .map((entry) => Rank(
              username: entry.key,
              rankNumber: 0,
              country: entry.value[0],
              score: entry.value[1].toString(),
            ))
        .toList();
    players.sort((b, a) => int.parse(a.score).compareTo(int.parse(b.score)));
    for (int i = 0; i < players.length; i++) {
      var rank = players[i];
      players[i] = Rank(
          country: rank.country,
          score: rank.score,
          username: rank.username,
          rankNumber: i + 1);
    }
    if (mounted) {
      setState(() {
        loaded = true;
      });
    }
  }

  @override
  void initState() {
    getPlayers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color blue = Color.fromARGB(255, 13, 77, 174);
    double _width = MediaQuery.of(context).size.width;
    if (!loaded) return Container();
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
                  Container(
                    width: _width,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          blue,
                          const Color.fromARGB(255, 159, 31, 31),
                        ],
                      ),
                    ),
                    child: Row(children: [
                      Container(
                        width: 70,
                        height: 70,
                        margin: const EdgeInsets.only(left: 10),
                        child: CircleAvatar(
                          child: ClipOval(
                            child: widget.player.avatar,
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 30,
                          color: Colors.transparent,
                          child: ClipRRect(
                              //used to make circular borders
                              borderRadius: BorderRadius.circular(15),
                              child: Center(
                                  child: Text(
                                widget.player.username,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )))),
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    width: _width - 60,
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                          depth: 30,
                          lightSource: LightSource.bottom,
                          color: Color.fromARGB(255, 232, 229, 229)),
                      child: const Center(
                          child: Text(
                        " Leaderboard",
                        style: TextStyle(fontSize: 26, color: Colors.black),
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                            margin: const EdgeInsets.only(right: 5, left: 5),
                            width: 115,
                            height: 80,
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20.0,
                                  color: Color.fromARGB(255, 125, 125, 125),
                                ),
                              ],
                            ),
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
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20.0,
                                  color: Color.fromARGB(255, 125, 125, 125),
                                ),
                              ],
                            ),
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
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20.0,
                                  color: Color.fromARGB(255, 125, 125, 125),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: ElevatedButton(
                                  onPressed: () {},
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
                    height: 25,
                  ),
                  Container(
                    height: 50,
                    width: _width,
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                          depth: 30,
                          lightSource: LightSource.top,
                          color: Color.fromARGB(255, 242, 239, 239)),
                      child: const Center(
                          child: Text(
                        " Global Rank",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
                              color: Colors.black),
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
                              color: Colors.black),
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
                              color: Colors.black),
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
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ] +
                players,
          ),
        ],
      )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              blue,
              Color.fromARGB(255, 159, 31, 31),
            ],
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          fixedColor: Colors.white,
          unselectedItemColor: Colors.white,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          player: widget.player,
                        )));
                break;
              case 1:
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => HomePage(
                          player: widget.player,
                        )));
                break;
              case 2:
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Leaderboard(
                          player: widget.player,
                        )));
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
      ),
    ));
  }
}
