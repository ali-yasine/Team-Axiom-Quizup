import 'package:flutter/material.dart';

class Answer extends StatefulWidget {
  final String ans;
  final Color colorOnPress;
  final VoidCallback ontap;
  final VoidCallback handleAnimation;
  const Answer(
      {Key? key,
      required this.ans,
      required this.colorOnPress,
      required this.ontap,
      required this.handleAnimation})
      : super(key: key);
  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  static const Color standardColor = Color.fromRGBO(51, 156, 244, 100);
  static const int delayInMili = 750;
  Color color = standardColor;
  void answered() {
    color = widget.colorOnPress;
    setState(() {});
  }

  @override
  void didUpdateWidget(Answer oldWidget) {
    super.didUpdateWidget(oldWidget);
    color = standardColor;
  }

  void update() async {
    answered();
    widget.handleAnimation();
    await Future.delayed(const Duration(milliseconds: delayInMili))
        .then((value) => widget.ontap());
  }

  @override
  Widget build(BuildContext context) {
    const int _width = 1000;
    const int _height = 50;
    return   Container(
        width: _width.toDouble(),
        height: _height.toDouble(),
    child: ClipRRect(
    //used to make circular borders
    borderRadius: BorderRadius.circular(25),
        child: ElevatedButton(

            child: Text(widget.ans),
            style: ElevatedButton.styleFrom(primary: color),
            onPressed: update), ));
  }
}
