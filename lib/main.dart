import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Backend%20Management/matchMaker.dart';
import 'Screens/Home.dart';
import 'Utilities/player.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var player = Player(
    username: "User2",
    email: "email@domain.com",
    avatar: const AssetImage("assets/images/panda.jpg"),
    gamesPlayed: 10,
    gamesWon: 6,
    avgSecondsToAnswer: 4,
    rankGlobal: 12,
    rankByCountry: 3,
  );
  await Firebase.initializeApp();
  runApp(HomePage(
    player: player,
  ));
}
