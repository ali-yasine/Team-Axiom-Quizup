import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Quizup',
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Quizup'),
            ),
            body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
              Container(
                height: 80,
                color: Colors.green[100],
                child: const Center(
                    child: Text(
                        'Which event is considered to be the first Offensive act of World War II? :')),
              ),
              Container(
                height: 80,
                color: Colors.white,
                child: const Center(
                    child: Text(
                        'Germany’s Operation Barbarossa against the Soviet Union.')),
              ),
              Container(
                height: 80,
                color: Colors.white,
                child: const Center(
                    child: Text('The Anschluss of Austria by Germany.')),
              ),
              Container(
                height: 80,
                color: Colors.white,
                child: const Center(child: Text('German attack on Poland.')),
              ),
              Container(
                height: 80,
                color: Colors.white,
                child: const Center(child: Text('Italian attack on Ethiopia.')),
              )
            ])));
  }
}
