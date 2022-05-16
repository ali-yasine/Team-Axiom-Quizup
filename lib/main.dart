import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Backend Management/fireConnect.dart';
import 'Login-Signup/Login.dart';
import 'Screens/Home.dart';
import 'Utilities/player.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: MainPage()));
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
    if (user == null) {
      user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        email = user!.email;
        getPlayer();
      }
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
        return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                      child: Text((""),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(246, 1, 81, 175)))),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 5,
                  ),
                  CircularProgressIndicator(),
                ]));
      }
    }
  }
}
