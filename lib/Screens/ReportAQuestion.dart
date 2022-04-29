import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Utilities/player.dart';
import '../Backend Management/fireConnect.dart';
import '../Quiz components/quiz.dart';
import '../Utilities/question_template.dart';
import 'Home.dart';

class ReportAQuestion extends StatefulWidget {
  final String subject;
  final Player player;
  const ReportAQuestion({
    Key? key,
    required this.subject,
    required this.player,
  }) : super(key: key);

  @override
  State<ReportAQuestion> createState() => _ReportAQuestionState();
}

class _ReportAQuestionState extends State<ReportAQuestion> {
  TextEditingController ReportController = TextEditingController();
  String? email;
  String? subject;
  void initState(){
    email = widget.player.email;
    subject = widget.subject;
    
  }
  

  @override
  Widget build(BuildContext context) {
  
    double _width = MediaQuery.of(context).size.width;
    const _profileRadius = 35.0;
    const _iconSize = 40.0;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[300],
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(children: [
            Flexible(
                child: Container(
              child: IconButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => HomePage(
                              player: widget.player,
                            ))),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
                iconSize: _iconSize,
              ),
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(10),
            )),
            Flexible(
                child: Row(children: [
                  Container(
                      child: CircleAvatar(
                          child: CircleAvatar(
                            radius: _profileRadius - 2,
                            backgroundColor: Colors.grey,
                            child: widget.player.avatar,
                          ),
                          radius: _profileRadius),
                      margin: const EdgeInsets.only(left: 10)),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 15),
                      width: 150,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color.fromARGB(255, 13, 77, 174),
                            width: 1,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Center(
                              child: FittedBox(
                                  child: Text(
                                    widget.player.username,
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 13, 77, 174)),
                                    textAlign: TextAlign.center,
                                  ),
                                  fit: BoxFit.cover)))),
                ]),
                flex: 20),
            Flexible(
                flex: 5,
                child: Container(
                  color: Colors.grey[300],
                )),
            Flexible(
                child: Container(
                  width: _width - 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: const Color.fromARGB(255, 13, 77, 174)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                      child: Text(
                    " Constest A Question",
                    style: TextStyle(
                        fontSize: 26, color: Color.fromARGB(255, 13, 77, 174)),
                    textAlign: TextAlign.center,
                  )),
                ),
                flex: 9),
            Flexible(
                flex: 10,
                child: Container(
                  color: Colors.grey[300],
                )),
            Flexible(
              flex: 20,
              child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromARGB(255, 13, 77, 174),
                        width: 2,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: TextField(
                    controller: ReportController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: '  Description',
                      contentPadding: EdgeInsets.symmetric(vertical: 55.0),
                    ),
                  )),
            ),
            Flexible(
                flex: 5,
                child: Container(
                  color: Colors.grey[300],
                )),
            Flexible(
                flex: 16,
                child: Container(
                    margin: const EdgeInsets.only(left: 25.0),
                    width: 150,
                    height: 50,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: ElevatedButton(
                          onPressed: () => {
                            FireConnect.submitReport(ReportController.text,subject,email)
                          },
                          child: const Text(
                            "Send",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 13, 77, 174),
                          )),
                        )))),
          ]),
        ));
  }
}
