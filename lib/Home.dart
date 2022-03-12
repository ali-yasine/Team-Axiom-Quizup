import 'package:quizup_prototype_1/player.dart';
import 'package:quizup_prototype_1/question_template.dart';
import 'quiz.dart';
import 'package:flutter/material.dart';

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
    double _width = MediaQuery. of(context). size. width ;
    double _height= MediaQuery. of(context). size. height ;
    return Scaffold(
      backgroundColor: Color.fromRGBO(207, 232, 255, 20),
      body:
      Column(
        children:
        <Widget>[
          Container(
            width: _width,
            height: 100,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(51, 156, 254, 10),
              border: Border.all(
                color: const Color.fromRGBO(51, 156, 254, 10),
                width: 2,
              ),
              borderRadius:const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight:  Radius.circular(20),
              ),),
            child:Row(children:[
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 15.0, left: 105.0),
                  width: 150,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromRGBO(51, 156, 254, 10),
                        width: 1,
                      ),
                      borderRadius:const  BorderRadius.all(Radius.circular(25))),
                  child: ClipRRect(
                    //used to make circular borders
                      borderRadius:BorderRadius.circular(15),
                      child: const Center(
                          child: Text(
                            " username",
                            style: const TextStyle(
                                fontSize: 12,
                                color:const  Color.fromRGBO(51, 156, 254, 10)),
                            textAlign: TextAlign.center,
                          )))),
              Container(
                  margin:const EdgeInsets.only(right: 5.0,left: 50),

                  child: ElevatedButton(

                    onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const HomePage())),
                    child:const Icon(IconData(0xe57f, fontFamily: 'MaterialIcons',),
                      color: Colors.white,
                      size: 33,

                    ),
                  ) )]),
          ),
          Row(children:[Container(
              margin: const EdgeInsets.only(right: 5.0, left: 5.0),
              alignment:Alignment.center,
              width: 400,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color.fromRGBO(51, 156, 254, 10),
                    width: 1,
                  ),
                  borderRadius:const  BorderRadius.all(Radius.circular(25))),

              child:Row(children:[ const Center(
                  child: const Text(
                    "search",
                    style:const  TextStyle(
                        fontSize: 12,
                        color:const Color.fromRGBO(51, 156, 254, 10)),
                    textAlign: TextAlign.center,

                  )),
                Container(
                    alignment: Alignment.center,
                    width: 30,
                    height: 30,
                    margin:const EdgeInsets.only(right: 5.0,left: 327),
                    decoration: BoxDecoration(
                        borderRadius:const  BorderRadius.all(Radius.circular(300))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(300),
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const HomePage())),


                        icon:const Icon(Icons.search, size: 18,color: Color.fromRGBO(51, 156, 254, 10),),),


                    )
                ),





              ]))
          ]),

          const SizedBox(height: 30,),

     SingleChildScrollView(
    child: Column(
    children: <Widget>[
          new SizedBox(
            width: 500,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(51, 156, 244, 100),
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
                        player: Player(username: "player", id: "1"),
                        subject: 'Natural Science',
                      )));
                },
                child: const Text('Natural Science')),
          ),
           const SizedBox(height: 10),
          new SizedBox(
            width: 500,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(51, 156, 244, 100),
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
                        player: Player(username: "player", id: "2"),
                        subject: 'Sports',
                      )));
                },
                child: const Text('Sports')),
          ),


          Row(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [

              Container(
                alignment: Alignment.bottomCenter,
                width: _width,
                height: 60,
                margin:  EdgeInsets.only(top : MediaQuery. of(context). size. height -350 ),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(51, 156, 254, 10),
                  border: Border.all(
                    color: const Color.fromRGBO(51, 156, 254, 10),
                    width: 2,
                  ),
                  borderRadius:const BorderRadius.only(
                    topLeft:const  Radius.circular(20),
                    topRight: const  Radius.circular(20),
                  ),),
                child: Row(children: [
                  Container(
                      margin:const EdgeInsets.only(right: 5.0,left: 50),

                      child: ElevatedButton(

                        onPressed: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const HomePage())),
                        child:const Icon(IconData(0xe491, fontFamily: 'MaterialIcons',),
                          color: Colors.white,
                          size: 33,

                        ),
                      ) ),
                  Container(
                      margin:const EdgeInsets.only(right: 5.0,left: 50),

                      child: ElevatedButton(

                        onPressed: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const HomePage())),
                        child:const Icon(IconData(0xf3f9, fontFamily: 'MaterialIcons',),
                          color: Colors.white,
                          size: 33,

                        ),
                      ) ),
                  Container(
                      margin:const EdgeInsets.only(right: 5.0,left: 50),

                      child: ElevatedButton(

                        onPressed: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const HomePage())),
                        child:const Icon(IconData(0xe36f, fontFamily: 'MaterialIcons',),
                          color: Colors.white,
                          size: 33,

                        ),
                      ) ),
                ],
                ),
              )],)
        ],
      ),


    ),]));
  }
}
