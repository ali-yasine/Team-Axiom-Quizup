import 'package:flutter/material.dart';

const Color _STANDARDCOLOR = Color.fromARGB(255, 76, 151, 144);

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
  Color color = _STANDARDCOLOR;
  void answered() {
    color = widget.colorOnPress;
    setState(() {});
  }

  @override
  void didUpdateWidget(Answer oldWidget) {
    super.didUpdateWidget(oldWidget);
    color = _STANDARDCOLOR;
  }

  void update() async {
    answered();
    widget.handleAnimation();
    await Future.delayed(const Duration(milliseconds: 750))
        .then((value) => widget.ontap());
  }

  @override
  Widget build(BuildContext context) {
    const int _width = 400;
    const int _height = 40;
    return SizedBox(
        child: ElevatedButton(
            child: Text(widget.ans),
            style: ElevatedButton.styleFrom(primary: color),
            onPressed: update),
        width: _width.toDouble(),
        height: _height.toDouble());
  }
}
