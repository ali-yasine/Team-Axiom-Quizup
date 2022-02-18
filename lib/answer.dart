import 'package:flutter/material.dart';

class Answer extends StatefulWidget {
  final String ans;
  final Color colorOnPress;
  final VoidCallback ontap;
  static void test() {}
  const Answer(
      {Key? key,
      required this.ans,
      required this.colorOnPress,
      required this.ontap})
      : super(key: key);
  // ignore: prefer_final_fields
  // bool _hasBeenPressed = false;
  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  Color color = const Color.fromARGB(255, 76, 151, 144);
  void answered() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            child: Text(widget.ans),
            style: ElevatedButton.styleFrom(primary: color),
            onPressed: () =>
                {widget.ontap, color = widget.colorOnPress, answered()}));
  }
}
