import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController EmailController = TextEditingController();
  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: EmailController.text);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Colors.grey[300];
    return MaterialApp(
      home:Scaffold(
        body:Padding(
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
                'Reset your Password',
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
                  controller: EmailController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your email address',
                  ),
                ),
              )),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
              width: 100,
              height: 50,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: ElevatedButton(
                    onPressed: () {
                      resetPassword();
                    },
                    child: const Text(
                      "Send Email",
                      style: TextStyle(fontSize: 13, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 13, 77, 174))),
                  )))
        ],
      ),
    )));
  }
}
