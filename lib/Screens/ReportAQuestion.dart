import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../Backend Management/fireConnect.dart';

import '../Utilities/player.dart';
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
  void initState() {
    email = widget.player.email;
    subject = widget.subject;
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    const _profileRadius = 35.0;
    const _iconSize = 40.0;
    Color blue = Color.fromARGB(255, 13, 77, 174);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: Column(children: [
        Container(
          width: _width,
          height: 120,
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
          child: Row(children: [
            Container(
              width: 70,
              height: 70,
              margin: const EdgeInsets.only(left: 10),
              child: CircleAvatar(
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.transparent,
                  child: widget.player.avatar,
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
                width: 150,
                height: 30,
                color: Colors.transparent,
                child: ClipRRect(
                    //used to make circular borders
                    borderRadius: BorderRadius.circular(15),
                    child: Center(
                        child: Text(
                      widget.player.username,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )))),
          ]),
        ),
        Flexible(
            flex: 5,
            child: Container(
              color: Colors.grey[300],
            )),
        Flexible(
            child: Container(
              width: _width - 60,
              child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    depth: 30,
                    lightSource: LightSource.bottom,
                    color: Color.fromARGB(255, 232, 229, 229)),
                child: const Center(
                    child: Text(
                  " Contest A Question",
                  style: TextStyle(fontSize: 26, color: Colors.black),
                  textAlign: TextAlign.center,
                )),
              ),
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
            width: _width - 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    depth: 30,
                    lightSource: LightSource.top,
                    color: Color.fromARGB(255, 232, 229, 229)),
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
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20.0,
                      color: Color.fromARGB(255, 125, 125, 125),
                    ),
                  ],
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ElevatedButton(
                      onPressed: () => {
                        FireConnect.submitReport(
                            ReportController.text, subject, email)
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
    );
  }
}
