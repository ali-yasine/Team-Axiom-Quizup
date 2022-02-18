import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/question.dart';
import 'answer.dart';

void main() => runApp(const MaterialApp(home: home()));

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String gamername = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome to Quizup',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        titleTextStyle: TextStyle(fontStyle: FontStyle.italic),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 52, 80, 92),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: "Gamer name", labelText: "Gamer name"),
              onChanged: (text) {
                gamername = text;
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Page2(gamername: gamername)));
        },
        child: Text('SAVE', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 52, 80, 92),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  Page2({Key? key, required this.gamername}) : super(key: key);
  String gamername;

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        titleTextStyle: TextStyle(fontStyle: FontStyle.italic),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 52, 80, 92),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Icon(Icons.airline_seat_recline_normal_outlined,
                  color: Colors.teal[300]),
              Text(widget.gamername),
            ]),
            Container(
              width: double.infinity,
              child: RaisedButton(
                  textColor: Colors.white,
                  color: Color.fromARGB(255, 76, 151, 144),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HistoryPage()));
                  },
                  child: Text('History')),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: RaisedButton(
                  textColor: Colors.white,
                  color: Color.fromARGB(255, 76, 151, 144),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Animalpage()));
                  },
                  child: Text('Animals')),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Question(
        prompt: 'What was the name given to the German Airforce during WW2:',
        wrongAnswersTxt: const [
          "Wehrmacht.",
          "Deutschen Kaiserreiches.",
          "Kriegsmarine."
        ],
        correctAnswerTxt: 'Luftwaffe.',
        subject: "History");
  }
}

class Animalpage extends StatefulWidget {
  const Animalpage({Key? key}) : super(key: key);
  @override
  _Animalpage createState() => _Animalpage();
}

class _Animalpage extends State<Animalpage> {
  @override
  Widget build(BuildContext context) {
    return Question(
      prompt: 'The scientific name of the Giant Panda is:',
      correctAnswerTxt: 'Ailuropoda melanoleuca',
      wrongAnswersTxt: const [
        'Ursus maritimus',
        'Loxodonta cyclotis',
        'Elephas maximus'
      ],
      subject: 'Animals',
    );
  }
}
