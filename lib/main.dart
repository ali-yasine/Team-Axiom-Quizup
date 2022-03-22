import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: HomePage()));
}
