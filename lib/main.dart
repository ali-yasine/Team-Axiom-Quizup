import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Login-Signup/Login.dart';
import 'package:quizup_prototype_1/Screens/ResultsScreen.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var player = Player(
      email: "email",
      country: "country",
      username: "username",
      avatar: Image.asset(
        'assets/images/panda.jpg',
      ),
      gamesWon: 2,
      avgSecondsToAnswer: 2,
      gamesPlayed: 2);
  runApp(MaterialApp(
      home: Results(
          player: player,
          score: 2,
          subject: "Computer Science",
          correct: 2,
          incorrect: 2,
          opponentScore: 2)));
}
