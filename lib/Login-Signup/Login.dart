// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Screens/Home.dart';
import 'package:quizup_prototype_1/Login-Signup/SignUp.dart';

import '../Screens/Home.dart';
import '../Utilities/player.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Colors.grey[300];
    return MaterialApp(
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final img = const AssetImage("assets/images/panda.jpg");
  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: nameController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: nameController.text);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Color.fromARGB(255, 13, 77, 174),
                    fontWeight: FontWeight.bold,
                    fontSize: 34,
                  ),
                )),
            const SizedBox(
              height: 50,
            ),
            Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 13, 77, 174),
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: ClipRRect(
                  //used to make circular borders
                  borderRadius: BorderRadius.circular(30),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: '  Username or email address',
                    ),
                  ),
                )),
            const SizedBox(
              height: 30,
            ),
            Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 13, 77, 174),
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: ClipRRect(
                  //used to make circular borders
                  borderRadius: BorderRadius.circular(30),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: '  Password',
                    ),
                  ),
                )),
            TextButton(
              onPressed: () {
                resetPassword();
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            SizedBox(
                width: 100,
                height: 50,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: ElevatedButton(
                      onPressed: () {
                        signIn();
                        FirebaseAuth.instance
                            .authStateChanges()
                            .listen((User? user) {
                          if (user == null) {
                            print('User is currently signed out!');
                          } else {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    //TODO fix hardcoded player
                                    builder: (context) => HomePage(
                                          player: Player(
                                            username: "user",
                                            email: "email@domain.com",
                                            avatar: img,
                                            gamesPlayed: 10,
                                            gamesWon: 6,
                                            avgSecondsToAnswer: 4,
                                            rankGlobal: 12,
                                            rankByCountry: 3,
                                          ),
                                        )));
                          }
                        });
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 13, 77, 174))),
                    ))),
            Row(
              children: <Widget>[
                const Text('Do not have account?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 13, 77, 174),
                    )),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const SignUp())),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}
