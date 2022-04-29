// ignore_for_file: file_names

import 'package:file_picker/file_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:quizup_prototype_1/Backend%20Management/fireConnect.dart';
import 'package:quizup_prototype_1/Screens/Leaderboard.dart';
import 'package:quizup_prototype_1/Screens/subject_screen.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Utilities/subject_icon.dart';
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
    Color blue = Color.fromARGB(255, 13, 77, 174);

    double _width = MediaQuery.of(context).size.width;
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  width: _width,
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [
                        blue,
                        Color.fromARGB(255, 159, 31, 31),
                      ],
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
                              child: ClipOval(
                                  child: Expanded(
                                child: ClipOval(child: widget.player.avatar),
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
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  width: _width - 20,
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
                        depth: 30,
                        lightSource: LightSource.top,
                        color: Color.fromARGB(255, 244, 241, 241)),
                    child: Center(
                        child: Text(
                      widget.player.email,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
                Container(
                    width: _width,
                    height: 38,
                    child: const Center(
                        child: Text(
                      " Email Address",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ))),
                Row(children: [
                  Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                      )),
                  Container(
                    width: _width / 3 - 20,
                    height: 60,
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                          depth: 30,
                          lightSource: LightSource.top,
                          color: Color.fromARGB(255, 244, 241, 241)),
                      child: Center(
                        child: Text(
                          (widget.player.gamesWon / widget.player.gamesPlayed)
                              .toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 40, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                      )),
                  Container(
                    width: _width / 3 - 20,
                    height: 60,
                    child: Neumorphic(
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.concave,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(12)),
                            depth: 30,
                            lightSource: LightSource.top,
                            color: Color.fromARGB(255, 244, 241, 241)),
                        child: Center(
                          child: Text(
                            widget.player.gamesPlayed.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 40, color: Colors.black),
                          ),
                        )),
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                      )),
                  Container(
                    width: _width / 3 - 20,
                    height: 60,
                    child: Neumorphic(
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.concave,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(12)),
                            depth: 30,
                            lightSource: LightSource.top,
                            color: Color.fromARGB(255, 244, 241, 241)),
                        child: const Center(
                          child: Text(
                            //TODO fix hardcoded rank
                            "3",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40, color: Colors.black),
                          ),
                        )),
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
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
                            color: Colors.black,
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
                            color: Colors.black,
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
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ))),
                  ],
                ),
                const SizedBox(height: 10),
                Row(children: [
                  Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                      )),
                  Container(
                    width: _width / 3 - 20,
                    height: 60,
                    child: Neumorphic(
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.concave,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(12)),
                            depth: 30,
                            lightSource: LightSource.top,
                            color: Color.fromARGB(255, 244, 241, 241)),
                        child: Center(
                          child: Text(
                            widget.player.gamesPlayed.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 40, color: Colors.black),
                          ),
                        )),
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                      )),
                  Container(
                    width: _width / 3 - 20,
                    height: 60,
                    child: Neumorphic(
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.concave,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(12)),
                            depth: 30,
                            lightSource: LightSource.top,
                            color: Color.fromARGB(255, 244, 241, 241)),
                        child: Center(
                          child: Text(
                            widget.player.gamesWon.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 40, color: Colors.black),
                          ),
                        )),
                  ),
                  Flexible(
                      flex: 8,
                      child: Container(
                        color: Colors.white,
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
                            color: Colors.black,
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
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ))),
                  ],
                ),
                const SizedBox(height: 10),

                //TODO REMOVE HARDCODE
                SubjectIcon(
                    subject: "Mathematics",
                    onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => SubjectScreen(
                                subject: "Mathematics",
                                player: widget.player)))),
                Container(
                    width: _width,
                    height: 38,
                    child: const Center(
                        child: Text(
                      " Most played subject",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.topLeft,
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
