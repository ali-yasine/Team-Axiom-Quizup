import 'dart:io';

import 'package:quizup_prototype_1/player.dart';
import 'package:quizup_prototype_1/subject_icon.dart';
import 'package:quizup_prototype_1/subject_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _home();
}

class _home extends State<HomePage> {
  final List<String> subjectNames = ["Natural science", "Sports"];
  Player player = Player(username: "user", id: "1234");
  List<subject_icon>? allSubjects;
  List<subject_icon> currentSubjects = [];
  @override
  void initState() {
    initializeSubjects(context);
    super.initState();
  }

  void initializeSubjects(BuildContext context) {
    List<subject_icon> icons = [];
    for (var name in subjectNames) {
      icons.add(subject_icon(
          subject: name,
          imageRef: "assets/images/Sports.png",
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    subjectScreen(subject: name, player: player)));
          }));
    }
    allSubjects ??= icons;
    currentSubjects.addAll(allSubjects!);
  }

  void searchSubjects(String queury) {
    if (queury.isNotEmpty) {
      List<subject_icon> result = [];
      for (var item in allSubjects!) {
        if (item.subject.toLowerCase().contains(queury.toLowerCase())) {
          result.add(item);
        }
      }
      setState(() {
        currentSubjects.clear();
        currentSubjects.addAll(result);
      });
    } else {
      setState(() {
        currentSubjects.clear();
        currentSubjects.addAll(allSubjects!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
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
              child: TextField(
                autofillHints: subjectNames,
                onChanged: (queury) => {searchSubjects(queury)},
              ),
            ),
          ]),
          const SizedBox(
            height: 30,
          ),
          Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Row(children: currentSubjects),
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
