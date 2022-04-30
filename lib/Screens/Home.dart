// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:quizup_prototype_1/OfflineQuiz/offlineQuiz.dart';
import 'package:quizup_prototype_1/Screens/Leaderboard.dart';
import 'package:quizup_prototype_1/Screens/Profile.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import 'package:quizup_prototype_1/Utilities/subject_icon.dart';
import 'package:quizup_prototype_1/Screens/subject_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../Backend Management/fireConnect.dart';
import '../Utilities/question_template.dart';
import 'Settings.dart';

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
  bool checkedForChallenges = false;
  Future<void> checkforChallenges(BuildContext context) async {
    var query = await FirebaseFirestore.instance
        .collection('OfflineChallenges')
        .where('Player2', isEqualTo: widget.player.username)
        .get();
    if (query.docs.isNotEmpty) {
      for (var doc in query.docs) {
        var docData = doc.data();
        if (!(docData['Player2 notified'])) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("You received a challenge!"),
                    content: Text(
                        "${docData['Player1']} challenged you to a match of ${docData['subject']} while you where away. Do you think you can beat their attempt?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            doc.reference.update({"Player2 notified": true});
                            Navigator.pop(context);
                          },
                          child: const Text('Ignore ')),
                      TextButton(
                          onPressed: () async {
                            doc.reference.update({"Player2 notified": true});
                            var questions = docData['Questions']
                                .map<QuestionTemplate>(
                                    (e) => QuestionTemplate.fromJson(e))
                                .toList();
                            var opponent =
                                await FireConnect.getPlayer(docData['Player1']);
                            var opponentScore = docData['Player1 Score'];
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => OfflineQuiz(
                                          questionTemplates: questions,
                                          player: widget.player,
                                          gameID: doc.reference.id,
                                          playerNum: 2,
                                          opponentScore: opponentScore,
                                          subject: docData['subject'],
                                          opponent: opponent,
                                        )));
                          },
                          child: const Text('Play'))
                    ],
                  ));
        }
      }
    }
  }

  Future<void> initializeSubjects() async {
    subjectNames = await FireConnect.getSubjects();
    subjectIcons = subjectNames
        .map((subject) => SubjectIcon(
            subject: subject,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    SubjectScreen(subject: subject, player: widget.player)))))
        .toList();
    currentSubjectIcons.addAll(subjectIcons);
    if (mounted) {
      setState(() {});
    }
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
    if (!checkedForChallenges) {
      checkforChallenges(context);
      checkedForChallenges = true;
    }
    Color blue = const Color.fromARGB(255, 13, 77, 174);
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Stack(children: <Widget>[
        Column(children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
                width: _width,
                height: 240,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      blue,
                      Color.fromARGB(255, 159, 31, 31),
                    ],
                  ),
                  border: Border.all(
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(children: [
                      Container(
                        width: 60,
                        height: 60,
                        margin: const EdgeInsets.only(left: 5),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.transparent,
                          child: widget.player.avatar,
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.transparent,
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
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )))),
                      Flexible(
                          flex: 4,
                          child: Container(
                            color: blue,
                          )),
                      Container(
                        child: IconButton(
                          onPressed: () => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => SettingsPage(
                                        player: widget.player,
                                      ))),
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          iconSize: 40,
                        ),
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.all(10),
                      ),
                      Flexible(
                          flex: 1,
                          child: Container(
                            color: blue,
                          )),
                    ]),
                    Row(children: [
                      Flexible(
                          flex: 1,
                          child: Container(
                            color: blue,
                          )),
                      Container(
                          margin: const EdgeInsets.only(right: 5.0, left: 5.0),
                          alignment: Alignment.center,
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: blue,
                                width: 1,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25))),
                          child: Row(children: [
                            Flexible(
                              child: Center(
                                child: TextField(
                                  onChanged: (queury) =>
                                      {searchSubjects(queury)},
                                ),
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(300))),
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
                      Flexible(
                          flex: 1,
                          child: Container(
                            color: blue,
                          )),
                    ]),
                  ],
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(height: 10),
          Column(
            children: currentSubjectIcons,
          ),
        ]),
      ])),
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
    );
  }
}
