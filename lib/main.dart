import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/fireConnect.dart';
import 'package:quizup_prototype_1/player.dart';
import 'package:quizup_prototype_1/question_template.dart';
import 'package:quizup_prototype_1/subject_screen.dart';
import 'quiz.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomePage());
}

Player player = Player(username: "user", id: "231");

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _home());
  }
}

class _home extends StatelessWidget {
  getQuestions() async {
    print("started");
    var x = await fireConnect.readPlayers();
    print("done");
  }

  @override
  Widget build(BuildContext context) {
    getQuestions();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(207, 232, 255, 20),
      appBar: AppBar(
        title: const Text('Subjects',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        titleTextStyle: const TextStyle(fontStyle: FontStyle.italic),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 52, 80, 92),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          children: <Widget>[
            Row(children: const <Widget>[
              Icon(Icons.airline_seat_recline_normal_outlined,
                  color: Color.fromRGBO(51, 156, 244, 100)),
              Text("player"),
            ]),
            SizedBox(
              width: 500,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(51, 156, 244, 100),
                      textStyle: const TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => subjectScreen(
                            subject: "Natural Science",
                            player: player,
                            quiz: Quiz(
                              questionsTemplates: [
                                question_template(
                                    prompt:
                                        "Where does most of the digestive process take place?",
                                    correctAnswerTxt: "Small intestine",
                                    wrongAnswersTxt: [
                                      "Stomach",
                                      "Large intestine",
                                      "All of the above"
                                    ],
                                    subject: "Natural Science"),
                                question_template(
                                    prompt: "Which is the heaviest metal",
                                    wrongAnswersTxt: [
                                      "nickel",
                                      "mercury",
                                      "iron"
                                    ],
                                    correctAnswerTxt: "osmium",
                                    subject: "Natural Science"),
                                question_template(
                                    prompt:
                                        "An atom with more neutrons than protons is called",
                                    wrongAnswersTxt: [
                                      "None of the above",
                                      "Element",
                                      "Compound"
                                    ],
                                    correctAnswerTxt: "Isotope",
                                    subject: "Natural Science"),
                                question_template(
                                    prompt: "Which is called white poison?",
                                    wrongAnswersTxt: [
                                      "Glucose",
                                      "Fructose",
                                      "Sweets"
                                    ],
                                    correctAnswerTxt: "Sugar",
                                    subject: "Natural Science"),
                                question_template(
                                    prompt: " The isotope atoms differ in",
                                    wrongAnswersTxt: [
                                      "number of protons",
                                      "atomic number",
                                      "number of electrons"
                                    ],
                                    correctAnswerTxt: "atomic weight",
                                    subject: "Natural Science")
                              ],
                              player: Player(username: "player", id: "1"),
                              subject: 'Natural Science',
                            ))));
                  },
                  child: const Text('Natural Science')),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 500,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(51, 156, 244, 100),
                      textStyle: const TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => subjectScreen(
                            subject: "Sports",
                            player: player,
                            quiz: Quiz(
                              questionsTemplates: [
                                question_template(
                                    prompt: "Who won the 2010 world cup",
                                    correctAnswerTxt: "Spain",
                                    wrongAnswersTxt: [
                                      "Germany",
                                      "Brazil",
                                      "Croatia"
                                    ],
                                    subject: "Sports"),
                                question_template(
                                    prompt: "Who won the Ballon-D'or in 2021",
                                    wrongAnswersTxt: [
                                      "Cristiano Ronaldo",
                                      "Karim Benzema",
                                      "Mohammed Salah"
                                    ],
                                    correctAnswerTxt: "Lionel Messi",
                                    subject: "Sports"),
                                question_template(
                                    prompt:
                                        "Who was the highest ranked tennis player in 2021",
                                    wrongAnswersTxt: [
                                      "Daniil Medvedev",
                                      "Alexander Zverev",
                                      "Stefanos Tsitsipas"
                                    ],
                                    correctAnswerTxt: "Novak Djokovic",
                                    subject: "Sports"),
                                question_template(
                                    prompt: "Which is called white poison?",
                                    wrongAnswersTxt: [
                                      "Glucose",
                                      "Fructose",
                                      "Sweets"
                                    ],
                                    correctAnswerTxt: "Sugar",
                                    subject: "Sports"),
                                question_template(
                                    prompt: "Who won the EURO in 2018",
                                    wrongAnswersTxt: [
                                      "Spain",
                                      "France",
                                      "Germany"
                                    ],
                                    correctAnswerTxt: "Portugal",
                                    subject: "Sports")
                              ],
                              player: Player(username: "player", id: "2"),
                              subject: 'Sports',
                            ))));
                  },
                  child: const Text('Sports')),
            ),
          ],
        ),
      ),
    );
  }
}
