import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Home.dart';
import 'package:quizup_prototype_1/SignUp.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);



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
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                    color: Color.fromRGBO(51, 156, 254, 10),
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                  ),
                )),
        const SizedBox(height: 50,),
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
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Forgot Password',),
            ),
        Container(
            width: 100,
            height: 50,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: ElevatedButton(
                  onPressed: ()
                  {Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                  print(nameController.text);
                  print(passwordController.text);
                    },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 13, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(51, 156, 254, 10))),
                ))),
            Row(
              children: <Widget>[
                const Text('Do not have account?', style: TextStyle(
                  color: Color.fromRGBO(51, 156, 254, 10),) ),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () =>Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => SignUp())),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}