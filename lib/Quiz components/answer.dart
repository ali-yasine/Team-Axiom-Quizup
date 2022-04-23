import 'package:flutter/material.dart';

class Answer extends StatefulWidget {
  final String ans;
  final String prompt;
  final Color colorOnPress;
  final VoidCallback ontap;
  final VoidCallback handleAnimation;
  const Answer(
      {Key? key,
      required this.ans,
      required this.prompt,
      required this.colorOnPress,
      required this.ontap,
      required this.handleAnimation})
      : super(key: key);
  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  static const Color standardColor = Color.fromRGBO(51, 156, 244, 100);
  Color color = standardColor;

  void update() async {
    widget.handleAnimation();
    setState(() {
      color = widget.colorOnPress;
    });
    await Future.delayed(const Duration(milliseconds: 20));
    widget.ontap();
  }

  @override
  void didUpdateWidget(covariant Answer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.prompt != widget.prompt) {
      color = standardColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    const int _width = 1000;
    const int _height = 50;
    return SizedBox(
        width: _width.toDouble(),
        height: _height.toDouble(),
        child: ClipRRect(
          //used to make circular borders
          borderRadius: BorderRadius.circular(25),
          child: ElevatedButton(
              child: Text(widget.ans),
              style: ElevatedButton.styleFrom(primary: color),
              onPressed: update),
        ));
  }
}
