// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Backend%20Management/fireConnect.dart';
import 'package:quizup_prototype_1/Screens/Home.dart';
import 'package:quizup_prototype_1/Login-Signup/SignUp.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Screens/Home.dart';
import '../Utilities/player.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future signIn() async {
    var email = emailController.text;
    try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: passwordController.text);
    } on FirebaseAuthException catch(e){
      Fluttertoast.showToast(
        msg: e.toString(),  // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.BOTTOM,
    );
    }
    Player? player;
    player = await FireConnect.getPlayerByEmail(email);
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print("Player is null: ${player == null}");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage(player: player!)));
      }
    });
  }

  Future resetPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Colors.grey[300];
    return MaterialApp(
        home: Scaffold(
            backgroundColor: backgroundColor,
            body: Padding(
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25))),
                        child: ClipRRect(
                          //used to make circular borders
                          borderRadius: BorderRadius.circular(30),
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email address',
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25))),
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
                              onPressed: signIn,
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
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
                          onPressed: () => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const SignUp())),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                ))));
  }
}
