// ignore_for_file: file_names
import 'package:quizup_prototype_1/Screens/Leaderboard.dart';
import 'package:quizup_prototype_1/Screens/Profile.dart';
import 'package:quizup_prototype_1/Screens/Settings.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import 'package:quizup_prototype_1/Utilities/subject_icon.dart';
import 'package:quizup_prototype_1/Screens/subject_screen.dart';
import 'package:flutter/material.dart';

import '../Backend Management/fireConnect.dart';

class HomePage extends StatelessWidget {
  final Player player;
  const HomePage({Key? key, required this.player}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home(player: player));
  }
}

class Home extends StatefulWidget {
  final Player player;
  const Home({Key? key, required this.player}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  bool _loadingSubjects = true;
  late final List<String> subjects;
  late final List<SubjectIcon> subjectIcons;
  Future<void> initializeSubjects() async {
    subjects = await FireConnect.getSubjects();
    subjectIcons = subjects
        .map((subject) => SubjectIcon(
            subject: subject,
            imageRef: 'assets/images/sports.png',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    SubjectScreen(subject: subject, player: widget.player)))))
        .toList();
    _loadingSubjects = false;
    setState(() {});
  }

  @override
  void initState() {
    initializeSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color blue = Color.fromARGB(255, 13, 77, 174);
    double _width = MediaQuery.of(context).size.width;
    if (_loadingSubjects) {
      return Column(children: const [
        CircularProgressIndicator(),
        Text("Loading subjects")
      ]);
    }
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
          child: Stack(children: <Widget>[
        Column(children: <Widget>[
          Container(
            width: _width,
            height: 100,
            decoration: BoxDecoration(
              color: blue,
              border: Border.all(
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
                        color: blue,
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
              Container(
                  margin: const EdgeInsets.only(right: 5.0, left: 70),
                  color: blue,
                  child: ElevatedButton(
                    onPressed: () => {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Settings()))
                    },
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
                      color: blue,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: Row(children: [
                  const Center(
                      child: Text(
                    "search",
                    style: TextStyle(
                        fontSize: 12, color: Color.fromARGB(255, 13, 77, 174)),
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
                          onPressed: () => {},
                          icon: const Icon(
                            Icons.search,
                            size: 18,
                            color: Color.fromARGB(255, 13, 77, 174),
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
              ListView(
                shrinkWrap: true,
                children: subjectIcons,
              ),
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
        backgroundColor: blue,
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
              break;
            case 2:
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Leaderboard()));
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
