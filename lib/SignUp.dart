import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Login.dart';
import 'Home.dart';

//Widget for input

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  @override
  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color.fromRGBO(207, 232, 255, 20);
    return const MaterialApp(
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
  TextEditingController FirstnameController = TextEditingController();
  TextEditingController LastnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ConfirmPasswordController = TextEditingController();
  TextEditingController CountryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(children: <Widget>[
          Container(
            child: IconButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Login())),
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
                  color: Color.fromRGBO(51, 156, 254, 10),
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
                      color: const Color.fromRGBO(51, 156, 254, 10),
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: ClipRRect(
                  //used to make circular borders
                  borderRadius: BorderRadius.circular(30),
                  child: TextField(
                    controller: LastnameController,
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
                      color: const Color.fromRGBO(51, 156, 254, 10),
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: ClipRRect(
                  //used to make circular borders
                  borderRadius: BorderRadius.circular(30),
                  child: TextField(
                    controller: FirstnameController,
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
                    color: const Color.fromRGBO(51, 156, 254, 10),
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(25))),
              child: ClipRRect(
                //used to make circular borders
                borderRadius: BorderRadius.circular(30),
                child: TextField(
                  controller: CountryController,
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
                    color: const Color.fromRGBO(51, 156, 254, 10),
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(25))),
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
                      color: const Color.fromRGBO(51, 156, 254, 10),
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
            Container(
                margin: const EdgeInsets.only(left: 10),
                height: 50,
                width: _width / 2 - 20,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromRGBO(51, 156, 254, 10),
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: ClipRRect(
                  //used to make circular borders
                  borderRadius: BorderRadius.circular(30),
                  child: TextField(
                    obscureText: true,
                    controller: ConfirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: '  Confirm password',
                    ),
                  ),
                )),
          ]),
          const SizedBox(
            height: 10,
          ),
          Container(
              width: 100,
              height: 50,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: ElevatedButton(
                    onPressed: () {
                      if (passwordController.text ==
                              ConfirmPasswordController.text &&
                          passwordController.text != "") {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                        print(FirstnameController.text);
                        print(LastnameController.text);
                        print(CountryController.text);
                        print(emailController.text);
                        print(passwordController.text);
                      } else {
                        child:
                        const Text(
                          "The passwords don't match",
                          style:
                              TextStyle(fontSize: 13, color: Colors.redAccent),
                          textAlign: TextAlign.center,
                        );
                      }
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 13, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(51, 156, 254, 10))),
                  )))
        ]));
  }
}
