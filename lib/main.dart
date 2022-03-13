import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'package:quizup_prototype_1/player.dart';
import 'package:quizup_prototype_1/subject_screen.dart';
import 'ResultsScreen.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomePage());
}
