import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Backend%20Management/fireConnect.dart';
import 'package:quizup_prototype_1/Login-Signup/Login.dart';
import '../Screens/Home.dart';

//Widget for input

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<void> signUp() async {
    if (passwordController.text == confirmPasswordController.text &&
        passwordController.text != "") {
      var email = emailController.text;
      var country = countryController.text;
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: passwordController.text);
      //TODO fix hardcoded player
      await FireConnect.addPlayer('username', email, country);
      var player = await FireConnect.getPlayerByEmail(email);
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomePage(player: player)));
        }
      });
    } else {
      const Text(
        "The passwords don't match",
        style: TextStyle(fontSize: 13, color: Colors.redAccent),
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    var backgroundColor = Colors.grey[300];

    return MaterialApp(
        home: Scaffold(
            backgroundColor: backgroundColor,
            body: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(children: <Widget>[
                  Container(
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const Login())),
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                      iconSize: 40,
                    ),
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.all(10),
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color.fromARGB(255, 13, 77, 174),
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(left: 5),
                    child: const CircleAvatar(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Container(
                        height: 50,
                        width: _width / 2 - 20,
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
                            controller: lastNameController,
                            decoration: const InputDecoration(
                              labelText: '  First name',
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 50,
                        width: _width / 2 - 20,
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
                            controller: firstNameController,
                            decoration: const InputDecoration(
                              labelText: '  Last name',
                            ),
                          ),
                        )),
                  ]),
                  const SizedBox(
                    height: 10,
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
                          controller: countryController,
                          decoration: const InputDecoration(
                            labelText: '  Country',
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
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
                            labelText: '  email address',
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Container(
                        height: 50,
                        width: _width / 2 - 20,
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
                    Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 50,
                        width: _width / 2 - 20,
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
                            controller: confirmPasswordController,
                            decoration: const InputDecoration(
                              labelText: '  Confirm password',
                            ),
                          ),
                        )),
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: 100,
                      height: 50,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: ElevatedButton(
                            onPressed: signUp,
                            child: const Text(
                              "Sign Up",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 13, 77, 174))),
                          )))
                ]))));
  }
}
