import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Backend%20Management/fireConnect.dart';
import 'package:quizup_prototype_1/Login-Signup/Login.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var player = await FireConnect.getPlayer("ali");
  runApp(const MaterialApp(home: Login()));
}
