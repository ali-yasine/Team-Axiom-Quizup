import 'package:flutter/material.dart';

class SubjectIcon extends StatelessWidget {
  final String subject;
  final VoidCallback onTap;
  const SubjectIcon({Key? key, required this.subject, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        margin: const EdgeInsets.only(right: 5.0, left: 5.0),
        child: InkWell(
          onTap: onTap, // Image tapped
          splashColor: Colors.white10, // Splash color over image
          child: Ink.image(
            fit: BoxFit.cover, // Fixes border issues
            width: _width - 50,
            height: _width / 3 - 20,
            image: AssetImage('assets/images/$subject.jpeg'),
          ),
        ),
      ),
      Text(
        subject,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 22,
          color: Color.fromARGB(255, 13, 77, 174),
          fontWeight: FontWeight.bold,
        ),
      ),
    ]);
  }
}
