import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Backend%20Management/fireConnect.dart';
import 'package:quizup_prototype_1/Backend%20Management/matchMaker.dart';
import 'package:quizup_prototype_1/Login-Signup/Login.dart';
import 'package:quizup_prototype_1/Screens/PlayerAssigned.dart';
import 'package:quizup_prototype_1/Screens/Settings.dart';
import 'Screens/Home.dart';
import 'Screens/ChallengeAFriend.dart';

import 'Screens/JoinARoom.dart';
import 'Utilities/player.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var player4 = Player(
    username: "User3",
    email: "email@domain.com",
    avatar: const AssetImage("assets/images/panda.jpg"),
    gamesPlayed: 10,
    gamesWon: 6,
    avgSecondsToAnswer: 4,
    rankGlobal: 12,
    rankByCountry: 3,
  );
  var player3 = Player(
    username: "User4",
    email: "email1@domain.com",
    avatar: const AssetImage("assets/images/panda.jpg"),
    gamesPlayed: 10,
    gamesWon: 6,
    avgSecondsToAnswer: 4,
    rankGlobal: 12,
    rankByCountry: 3,
  );
  await Firebase.initializeApp();
  runApp(MaterialApp(home: Login()));
}

/*class MainPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Player player =
                  FireConnect.getPlayerByEmail(User.email!) as Player;
              return Home(player: player);
            } else {
              return Login();
            }
          },
        ),
      );
}*/

class UploadImages extends StatelessWidget {
  const UploadImages({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          InkWell(
            child: const CircleAvatar(
              child: CircleAvatar(
                radius: 57.5,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
            ),
            onTap: () async {
              final results = await FilePicker.platform.pickFiles(
                allowMultiple: false,
                type: FileType.image,
              );
              if (results == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("no file was picked")));
              } else {
                final path = results.files.single.path;
                const filename = "Yassinov";
                FireConnect.uploadAvatar(path!, filename);
              }
            },
          )
        ],
      ),
    );
  }
}
