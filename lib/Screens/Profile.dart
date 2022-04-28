// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:quizup_prototype_1/Backend%20Management/fireConnect.dart';
import 'package:quizup_prototype_1/Screens/Leaderboard.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import 'package:flutter/material.dart';
import 'Home.dart';

class ProfilePage extends StatefulWidget {
  Player player;
  ProfilePage({Key? key, required this.player}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  Future uploadImage() async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    String imagePath;
    if (results == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("no file was picked")));
    } else {
      imagePath = results.files.single.path!;
      await FireConnect.uploadAvatar(imagePath, widget.player.username);
      widget.player = await FireConnect.getPlayer(widget.player.username);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  width: _width,
                  height: 150,
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
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      Center(
                        child: Container(
                            width: 120,
                            height: 120,
                            margin: const EdgeInsets.only(left: 140.0),
                            child: InkWell(
                              child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.grey,
                                  child: Expanded(
                                    child:
                                        ClipOval(child: widget.player.avatar),
                                  )),
                              onTap: () async {
                                uploadImage();
                              },
                            )),
                      )
                    ]),
                  ])),
              const SizedBox(
                height: 10,
              ),
              Column(children: <Widget>[
                Center(
                  child: Text(widget.player.username,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 13, 77, 174),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  width: _width - 15,
                  margin: const EdgeInsets.only(right: 5.0, left: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromARGB(255, 13, 77, 174),
                        width: 2,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: Center(
                      child: Text(
                    widget.player.email,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 13, 77, 174)),
                    textAlign: TextAlign.center,
                  )),
                ),
                Container(
                    width: _width,
                    height: 38,
                    child: const Center(
                        child: Text(
                      " Email Address",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 13, 77, 174),
                      ),
                    ))),
                Row(children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5.0, left: 10.0),
                    width: _width / 3 - 20,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 13, 77, 174),
                          width: 2,
                        ),
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25))),
                    child: Center(
                      child: Text(
                        (widget.player.gamesWon / widget.player.gamesPlayed)
                            .toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 40,
                            color: Color.fromARGB(255, 13, 77, 174)),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(right: 5.0, left: 5.0),
                      width: _width / 3 - 20,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 13, 77, 174),
                            width: 2,
                          ),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: Text(
                          widget.player.gamesPlayed.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 40,
                              color: Color.fromARGB(255, 13, 77, 174)),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(right: 5.0, left: 5.0),
                      width: _width / 3 - 20,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 13, 77, 174),
                            width: 2,
                          ),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: const Center(
                        child: Text(
                          //TODO fix hardcoded rank
                          "3",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 40,
                              color: Color.fromARGB(255, 13, 77, 174)),
                        ),
                      )),
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
                            color: Color.fromARGB(255, 13, 77, 174),
                          ),
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
                            color: Color.fromARGB(255, 13, 77, 174),
                          ),
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
                            color: Color.fromARGB(255, 13, 77, 174),
                          ),
                          textAlign: TextAlign.center,
                        ))),
                  ],
                ),
                const SizedBox(height: 10),
                Row(children: [
                  Container(
                      margin: const EdgeInsets.only(right: 5.0, left: 10.0),
                      width: _width / 3 - 20,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 13, 77, 174),
                            width: 2,
                          ),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: Text(
                          widget.player.gamesPlayed.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 40,
                              color: Color.fromARGB(255, 13, 77, 174)),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(right: 5.0, left: 5.0),
                      width: _width / 3 - 20,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 13, 77, 174),
                            width: 2,
                          ),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: Text(
                          widget.player.gamesWon.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 40,
                              color: Color.fromARGB(255, 13, 77, 174)),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(right: 5.0, left: 5.0),
                      width: _width / 3 - 20,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 13, 77, 174),
                            width: 2,
                          ),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: Text(
                          widget.player.avgSecondsToAnswer.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 40,
                              color: Color.fromARGB(255, 13, 77, 174)),
                        ),
                      )),
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
                            color: Color.fromARGB(255, 13, 77, 174),
                          ),
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
                            color: Color.fromARGB(255, 13, 77, 174),
                          ),
                          textAlign: TextAlign.center,
                        ))),
                    Container(
                        margin: const EdgeInsets.only(left: 50),
                        width: 80,
                        height: 42,
                        child: const Center(
                            child: Text(
                          "Average seconds to answer",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 13, 77, 174),
                          ),
                          textAlign: TextAlign.center,
                        ))),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                    margin: const EdgeInsets.only(right: 5.0, left: 5.0),
                    width: _width,
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 13, 77, 174),
                          width: 2,
                        ),
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25))),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Container(
                            width: _width / 3,
                            height: 90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: widget.player.avatar.image,
                                    fit: BoxFit.fill),
                                color: Colors.white,
                                border: Border.all(
                                  color: const Color.fromARGB(255, 13, 77, 174),
                                  width: 2,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(25))),
                          ),
                        ),
                        Container(
                            margin:
                                const EdgeInsets.only(right: 5.0, left: 5.0),
                            width: _width - _width / 3 - 10,
                            height: 60,
                            child: const Center(
                              child: Text(
                                "Computer Science",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 28,
                                    color: Color.fromARGB(255, 13, 77, 174)),
                              ),
                            )),
                      ],
                    )),
                Container(
                    width: _width,
                    height: 38,
                    child: const Center(
                        child: Text(
                      " Most played subject",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 13, 77, 174),
                      ),
                    ))),
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
        backgroundColor: const Color.fromARGB(255, 13, 77, 174),
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomePage(player: widget.player)));
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
    ));
  }
}
