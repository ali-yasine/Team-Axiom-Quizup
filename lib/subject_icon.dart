import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class subject_icon extends StatelessWidget {
  final String subject;
  final String imageRef;
  final VoidCallback onTap;

  const subject_icon(
      {Key? key,
      required this.subject,
      required this.imageRef,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(children: [
      Container(
        margin: const EdgeInsets.only(right: 5.0, left: 5.0),
        child: InkWell(
          onTap: onTap, // Image tapped
          splashColor: Colors.white10, // Splash color over image
          child: Ink.image(
            fit: BoxFit.cover, // Fixes border issues
            width: _width / 3 - 20,
            height: _width / 3 - 20,
            image: AssetImage(imageRef),
          ),
        ),
      ),
      Text(
        subject,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(51, 156, 254, 10),
          fontWeight: FontWeight.bold,
        ),
      ),
    ]);
  }
}
