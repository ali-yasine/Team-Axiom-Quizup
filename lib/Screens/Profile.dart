// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:quizup/Screens/subject_screen.dart';
import '../Backend Management/fireConnect.dart';
import '../Utilities/player.dart';
import '../Utilities/subject_icon.dart';
import 'Home.dart';
import 'Leaderboard.dart';

class ProfilePage extends StatefulWidget {
  Player player;
  ProfilePage({Key? key, required this.player}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  String? favoriteSubject;
  int? playerRank;
  int? countryRank;
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
  void initState() {
    super.initState();
  }

  Future<void> getRanks() async {
    playerRank = await FireConnect.getRank(widget.player.username, 'Global');
    countryRank = await FireConnect.getCountryRank(widget.player);
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getFavoriteSubject() async {
    var playerdoc = await FirebaseFirestore.instance
        .collection('SubjectsPerPlayer')
        .doc(widget.player.username)
        .get();
    if (playerdoc.exists) {
      Map<String, int>? subjectsplayed = playerdoc.data()!['subjects'];
      if (subjectsplayed == null) {
        favoriteSubject = null;
      } else {
        String mostplayed = "";
        int maxplayed = 0;
        for (var subject in subjectsplayed.keys) {
          if (subjectsplayed[subject]! > maxplayed) {
            mostplayed = subject;
          }
        }
        favoriteSubject = mostplayed;
      }
    }
  }

  String getSubjectTxt() =>
      (favoriteSubject == null) ? "Computer Science" : favoriteSubject!;
  AssetImage getImage() {
    if (favoriteSubject == null) {
      return const AssetImage('assets/images/Computer Science.jpeg');
    } else {
      return AssetImage('assets/images/$favoriteSubject.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color blue = Color.fromARGB(255, 13, 77, 174);
    getFavoriteSubject();
    getRanks();
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
                              child: ClipOval(child: widget.player.avatar),
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
                            (playerRank == null) ? "" : playerRank.toString(),
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
                            //TODO fix hardcoded rank
                            (countryRank) == null ? "" : countryRank.toString(),
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
                          " Games Won",
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
