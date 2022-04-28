// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizup_prototype_1/Screens/Leaderboard.dart';
import 'package:quizup_prototype_1/Screens/Profile.dart';
import 'package:quizup_prototype_1/Screens/Settings.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import 'package:quizup_prototype_1/Utilities/subject_icon.dart';
import 'package:quizup_prototype_1/Screens/subject_screen.dart';
import 'package:flutter/material.dart';

import '../Backend Management/fireConnect.dart';

class HomePage extends StatefulWidget {
  final Player player;
  const HomePage({Key? key, required this.player}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  List<SubjectIcon> currentSubjectIcons = [];
  late final List<String> subjectNames;
  late final List<SubjectIcon> subjectIcons;
  bool _loadingSubjects = true;

  Future<void> initializeSubjects() async {
    subjectNames = await FireConnect.getSubjects();
    subjectIcons = subjectNames
        .map((subject) => SubjectIcon(
            subject: subject,
            imageRef: 'assets/images/sports.png',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    SubjectScreen(subject: subject, player: widget.player)))))
        .toList();
    currentSubjectIcons.addAll(subjectIcons);
    _loadingSubjects = false;
    setState(() {});
  }

  void searchSubjects(String query) {
    if (query.isNotEmpty) {
      List<SubjectIcon> result = [];
      for (var item in subjectIcons) {
        if (item.subject.toLowerCase().contains(query.toLowerCase())) {
          result.add(item);
        }
      }
      setState(() {
        currentSubjectIcons = result;
      });
    } else {
      setState(() {
        currentSubjectIcons = subjectIcons;
      });
    }
  }

  @override
  void initState() {
    initializeSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color blue = const Color.fromARGB(255, 13, 77, 174);
    double _width = MediaQuery.of(context).size.width;

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
                child: CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.grey,
                  child: widget.player.avatar,
                ),
              ),
              Flexible(
                  flex: 1,
                  child: Container(
                    color: blue,
                  )),
              Container(
                  alignment: Alignment.center,
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
                      child: Center(
                          child: Text(
                        widget.player.username,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 13, 77, 174)),
                        textAlign: TextAlign.center,
                      )))),
              Flexible(
                  flex: 4,
                  child: Container(
                    color: blue,
                  )),
              Container(
                  color: blue,
                  child: ElevatedButton(
                    onPressed: () => {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Settings(
                                player: widget.player,
                              )))
                    },
                    child: const Icon(
                      IconData(
                        0xe57f,
                        fontFamily: 'MaterialIcons',
                      ),
                      color: Colors.white,
                      size: 33,
                    ),
                  )),
              Flexible(
                  flex: 1,
                  child: Container(
                    color: blue,
                  )),
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
                  Flexible(
                    child: Center(
                      child: TextField(
                        autofillHints: subjectNames,
                        onChanged: (queury) => {searchSubjects(queury)},
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 3,
                      child: Container(
                        color: Colors.white,
                      )),
                  Container(
                      alignment: Alignment.center,
                      width: 30,
                      height: 30,
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
          const SizedBox(height: 10),
          Column(
            children: currentSubjectIcons,
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
    );
  }
}
