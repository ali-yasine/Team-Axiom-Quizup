import 'package:quizup_prototype_1/Profile.dart';
import 'package:quizup_prototype_1/player.dart';
import 'package:quizup_prototype_1/question_template.dart';
import 'package:quizup_prototype_1/subject_icon.dart';
import 'package:quizup_prototype_1/subject_screen.dart';
import 'quiz.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _home());
  }
}

class _home extends StatelessWidget {
  Player player = Player(username: "user", id: "1234");
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(207, 232, 255, 20),
      body: SingleChildScrollView(
          child: Stack(children: <Widget>[
        Column(children: <Widget>[
          Container(
            width: _width,
            height: 100,
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
                        color: const Color.fromRGBO(51, 156, 254, 10),
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
                            color: Color.fromRGBO(51, 156, 254, 10)),
                        textAlign: TextAlign.center,
                      )))),
              Container(
                  margin: const EdgeInsets.only(right: 5.0, left: 70),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const HomePage())),
                    child: const Icon(
                      IconData(
                        0xe57f,
                        fontFamily: 'MaterialIcons',
                      ),
                      color: Colors.white,
                      size: 33,
                    ),
                  ))
            ]),
          ),
          Row(children: [
            Container(
                margin: const EdgeInsets.only(right: 5.0, left: 5.0),
                alignment: Alignment.center,
                width: 400,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromRGBO(51, 156, 254, 10),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: Row(children: [
                  const Center(
                      child: Text(
                    "search",
                    style: TextStyle(
                        fontSize: 12, color: Color.fromRGBO(51, 156, 254, 10)),
                    textAlign: TextAlign.center,
                  )),
                  Container(
                      alignment: Alignment.center,
                      width: 30,
                      height: 30,
                      margin: const EdgeInsets.only(right: 5.0, left: 327),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(300))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(300),
                        child: IconButton(
                          onPressed: () => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const HomePage())),
                          icon: const Icon(
                            Icons.search,
                            size: 18,
                            color: Color.fromRGBO(51, 156, 254, 10),
                          ),
                        ),
                      )),
                ])),
          ]),
          const SizedBox(
            height: 30,
          ),
          Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Row(children: [
                subject_icon(
                    subject: "Natural Science",
                    imageRef: 'assets/images/natural science.png',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => subjectScreen(
                              subject: "Natural science", player: player)));
                    }),
                subject_icon(
                    subject: "Sports",
                    imageRef: 'assets/images/sports.png',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => subjectScreen(
                              subject: "Sports", player: player)));
                    }),
              ]),
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
      ])),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(51, 156, 254, 10),
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ProfilePage(
                        player: player,
                      )));
              break;
            case 1:
              break;
            case 2:
              //TODO ADD LEADERBOARD TO NAVIGATOR
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()));
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
