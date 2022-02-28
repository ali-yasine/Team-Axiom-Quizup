import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/player.dart';
import 'package:quizup_prototype_1/question_template.dart';
import 'quiz.dart';

void main() => runApp(const HomePage());

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _home());
  }
}

class _home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Row(children: <Widget>[
              Icon(Icons.airline_seat_recline_normal_outlined,
                  color: Colors.teal[300]),
              const Text("player"),
            ]),
            SizedBox(
              width: 500,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 76, 151, 144),
                      textStyle: const TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Quiz(
                              questionsTemplates: [
                                question_template(
                                    prompt:
                                        "Where does most of the digestive process take place?",
                                    correctAnswerTxt: "Small intestine",
                                    wrongAnswersTxt: [
                                      "Stomach",
                                      "Large intestine",
                                      "All of the above"
                                    ]),
                                question_template(
                                    prompt: "Which is the heaviest metal",
                                    wrongAnswersTxt: [
                                      "nickel",
                                      "mercury",
                                      "iron"
                                    ],
                                    correctAnswerTxt: "osmium"),
                                question_template(
                                    prompt:
                                        "An atom with more neutrons than protons is called",
                                    wrongAnswersTxt: [
                                      "None of the above",
                                      "Element",
                                      "Compound"
                                    ],
                                    correctAnswerTxt: "Isotope"),
                                question_template(
                                    prompt: "Which is called white poison?",
                                    wrongAnswersTxt: [
                                      "Glucose",
                                      "Fructose",
                                      "Sweets"
                                    ],
                                    correctAnswerTxt: "Sugar"),
                                question_template(
                                    prompt: " The isotope atoms differ in",
                                    wrongAnswersTxt: [
                                      "number of protons",
                                      "atomic number",
                                      "number of electrons"
                                    ],
                                    correctAnswerTxt: "atomic weight")
                              ],
                              player: Player(username: "player"),
                              subject: 'Natural Science',
                            )));
                  },
                  child: const Text('Natural Science')),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 500,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 76, 151, 144),
                      textStyle: const TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Quiz(
                              questionsTemplates: [
                                question_template(
                                    prompt: "Who won the 2010 world cup",
                                    correctAnswerTxt: "Spain",
                                    wrongAnswersTxt: [
                                      "Germany",
                                      "Brazil",
                                      "Croatia"
                                    ]),
                                question_template(
                                    prompt: "Who won the Ballon-D'or in 2021",
                                    wrongAnswersTxt: [
                                      "Cristiano Ronaldo",
                                      "Karim Benzema",
                                      "Mohammed Salah"
                                    ],
                                    correctAnswerTxt: "Lionel Messi"),
                                question_template(
                                    prompt:
                                        "Who was the highest ranked tennis player in 2021",
                                    wrongAnswersTxt: [
                                      "Daniil Medvedev",
                                      "Alexander Zverev",
                                      "Stefanos Tsitsipas"
                                    ],
                                    correctAnswerTxt: "Novak Djokovic"),
                                question_template(
                                    prompt: "Which is called white poison?",
                                    wrongAnswersTxt: [
                                      "Glucose",
                                      "Fructose",
                                      "Sweets"
                                    ],
                                    correctAnswerTxt: "Sugar"),
                                question_template(
                                    prompt: "Who won the EURO in 2018",
                                    wrongAnswersTxt: [
                                      "Spain",
                                      "France",
                                      "Germany"
                                    ],
                                    correctAnswerTxt: "Portugal")
                              ],
                              player: Player(username: "player"),
                              subject: 'Sports',
                            )));
                  },
                  child: const Text('Sports')),
            ),
          ],
        ),
      ),
    );
  }
}
