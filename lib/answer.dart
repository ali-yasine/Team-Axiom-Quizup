import 'package:flutter/material.dart';

const Color _STANDARDCOLOR = Color.fromARGB(255, 76, 151, 144);

class Answer extends StatefulWidget {
  final String ans;
  final Color colorOnPress;
  final VoidCallback ontap;
  const Answer(
      {Key? key,
      required this.ans,
      required this.colorOnPress,
      required this.ontap})
      : super(key: key);
  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  Color color = _STANDARDCOLOR;
  void answered() {
    setState(() {});
  }

  @override
  void didUpdateWidget(Answer oldWidget) {
    super.didUpdateWidget(oldWidget);
    color = _STANDARDCOLOR;
  }

  void update() async {
    color = widget.colorOnPress;
    answered();
    await Future.delayed(const Duration(milliseconds: 750))
        .then((value) => widget.ontap());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width,
        child: ElevatedButton(
            child: Text(widget.ans),
            style: ElevatedButton.styleFrom(primary: color),
            onPressed: update));
  }
}
