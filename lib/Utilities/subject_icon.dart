import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SubjectIcon extends StatelessWidget {
  final String subject;
  final VoidCallback onTap;
  const SubjectIcon({Key? key, required this.subject, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Card(
        color: Color.fromARGB(255, 241, 241, 241),
        elevation: 15,
        shadowColor: Colors.grey[300],
        child: Row(
          children: [
            Container(
              child: InkWell(
                onTap: onTap, // Image tapped
                canRequestFocus: true,
                splashColor: Colors.white10, // Splash color over image
                child: Ink.image(
                  fit: BoxFit.cover, // Fixes border issues
                  width: _width / 3 - 20,
                  height: _width / 3 - 20,
                  image: AssetImage('assets/images/$subject.jpeg'),
                ),
              ),
              padding: EdgeInsets.only(right: 10),
            ),
            Text(
              subject,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 10,
      ),
    ]);
  }
}
