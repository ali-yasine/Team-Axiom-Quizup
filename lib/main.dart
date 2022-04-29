import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Login-Signup/Login.dart';
import 'Backend Management/fireConnect.dart';
import 'Screens/Home.dart';
import 'Utilities/player.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: Login()));
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  User? user;
  String? email;
  Player? player;
  bool gotPlayer = false;
  getPlayer() async {
    if (email != null) {
      player = await FireConnect.getPlayerByEmail(email!);

      setState(() {
        gotPlayer = true;
      });
    }
  }

  @override
  void initState() {
    if (user != null) {
      user = FirebaseAuth.instance.currentUser;
      email = user!.email;
      getPlayer();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Login();
    } else {
      if (gotPlayer) {
        return HomePage(player: player!);
      } else {
        //TODO replace with loading screen having game logo
        return Container();
      }
    }
  }
}
