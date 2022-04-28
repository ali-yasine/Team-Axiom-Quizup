import 'package:flutter/material.dart';

class Rank extends StatelessWidget {
  final int rankNumber;
  final String username;
  final String score;
  final String country;

  const Rank(
      {Key? key,
      required this.rankNumber,
      required this.username,
      required this.score,
      required this.country})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Container(
        height: 50,
        width: _width - 20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Text(
                rankNumber.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.yellow[700]),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                username,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                score.toString(),
                style: const TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                country,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
