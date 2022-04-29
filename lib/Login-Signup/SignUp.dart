import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Backend%20Management/fireConnect.dart';
import 'package:quizup_prototype_1/Login-Signup/Login.dart';
import '../Screens/Home.dart';
import 'package:csc_picker/csc_picker.dart';

//Widget for input

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  String countryvalue = "";
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String errorTxt = "";
  Image avatar = Image.asset("assets/images/avatar.png");
  String? imagePath;
  Future<void> signUp() async {
    if (passwordController.text == confirmPasswordController.text &&
        passwordController.text != "") {
      if (passwordController.text.length < 6) {
        setState(() {
          errorTxt = "Password should be at least 6 characters";
        });
      } else {
        var email = emailController.text;
        var country = countryController.text;
        bool succesfulCreation = true;
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email, password: passwordController.text);
        } on FirebaseAuthException catch (err) {
          switch (err.message) {
            case "The email address is already in use by another account.":
              errorTxt = err.message!;
              succesfulCreation = false;
              setState(() {});
          }
        } catch (error) {
          succesfulCreation = false;
          rethrow;
        }
        if (succesfulCreation) {
          //TODO ADD USERNAMECONTROLLER
          var addResult =
              await FireConnect.addPlayer('has  hem', email, country);
          if (addResult != "Player added") {
            setState(() {
              errorTxt = addResult;
            });
          }
          if (imagePath != null) {
            //TODO ADD USERNAME CONTROLLER
            FireConnect.uploadAvatar(imagePath!, "username");
          }
          var player = await FireConnect.getPlayerByEmail(email);
          FirebaseAuth.instance.authStateChanges().listen((User? user) {
            if (user != null) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomePage(player: player)));
            }
          });
        }
      }
    } else {
      setState(() {
        errorTxt = "Passwords do not  match";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    var backgroundColor = Colors.grey[300];
    Color blue = Color.fromARGB(255, 13, 77, 174);
    return MaterialApp(
        home: Scaffold(
            backgroundColor: backgroundColor,
            body: Container(
                height: _height,
                width: _width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      blue,
                      const Color.fromARGB(255, 159, 31, 31),
                    ],
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView(children: <Widget>[
                      Container(
                        child: IconButton(
                          onPressed: () => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
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
                              color: Colors.white,
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
                          child: InkWell(
                              onTap: () async {
                                final results =
                                    await FilePicker.platform.pickFiles(
                                  allowMultiple: false,
                                  type: FileType.image,
                                );
                                if (results == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("no file was picked")));
                                } else {
                                  imagePath = results.files.single.path;
                                  avatar = Image.file(File(imagePath!));
                                  setState(() {});
                                }
                              },
                              child: CircleAvatar(
                                radius: 57.5,
                                backgroundColor: Colors.grey,
                                child: avatar,
                              ))),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: ClipRRect(
                            //used to make circular borders
                            borderRadius: BorderRadius.circular(30),
                            child: TextField(
                              controller: usernameController,
                              decoration: const InputDecoration(
                                labelText: '  username',
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      CSCPicker(
                        ///Enable disable state dropdown
                        showStates: false,

                        /// Enable disable city drop down
                        showCities: false,

                        ///Enable (get flat with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only)
                        flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,

                        ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                        dropdownDecoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          color: Colors.white,
                        ),

                        ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                        disabledDropdownDecoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            color: const Color.fromARGB(255, 13, 77, 174),
                            border: Border.all(
                                color: const Color.fromARGB(255, 13, 77, 174),
                                width: 2)),

                        ///selected item style [OPTIONAL PARAMETER]
                        selectedItemStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),

                        ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                        dropdownHeadingStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),

                        ///DropdownDialog Item style [OPTIONAL PARAMETER]
                        dropdownItemStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),

                        onCountryChanged: (value) {
                          setState(() {
                            countryvalue = value;
                          });
                        },
                        onStateChanged: (value) => {},
                        onCityChanged: (value) => {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
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
                      Flexible(
                        flex: 6,
                        child: Row(children: [
                          Container(
                              height: 50,
                              width: _width / 2 - 20,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: ClipRRect(
                                //used to make circular borders
                                borderRadius: BorderRadius.circular(30),
                                child: TextField(
                                  obscureText: true,
                                  controller: confirmPasswordController,
                                  decoration: const InputDecoration(
                                    labelText: 'Confirm password',
                                  ),
                                ),
                              )),
                        ]),
                      ),
                      Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: SizedBox(
                            width: _width / 2 - 20,
                            child: Text(
                              errorTxt,
                              style: const TextStyle(fontSize: 14),
                            ),
                          )),
                      Flexible(
                          flex: 15,
                          child: Container(
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: ElevatedButton(
                                    onPressed: signUp,
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey))),
                              )))
                    ])))));
  }
}
