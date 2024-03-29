import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Answer extends StatefulWidget {
  final String ans;
  final String prompt;
  final Color colorOnPress;
  final VoidCallback ontap;
  final VoidCallback handleAnimation;
  bool isDisabled;
  Answer(
      {Key? key,
      required this.ans,
      required this.prompt,
      required this.colorOnPress,
      required this.ontap,
      required this.handleAnimation,
      this.isDisabled = false})
      : super(key: key);
  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  static const Color standardColor = Color.fromARGB(255, 13, 77, 174);
  late Color color;
  void update() {
    if (!widget.isDisabled) {
      widget.handleAnimation();
      setState(() {
        color = widget.colorOnPress;
      });
      Future.delayed(const Duration(milliseconds: 50))
          .then((value) => widget.ontap());
    }
  }

  @override
  void didUpdateWidget(covariant Answer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.prompt != widget.prompt) {
      color = standardColor;
    }
  }

  @override
  void initState() {
    color = standardColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const int _width = 1000;
    const int _height = 50;
    return SizedBox(
        width: _width.toDouble(),
        height: _height.toDouble(),
        child: Neumorphic(
            style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                depth: 30,
                lightSource: LightSource.bottom,
                color: const Color.fromARGB(255, 242, 239, 239)),
            child: ClipRRect(
                //used to make circular borders
                borderRadius: BorderRadius.circular(15),
                child: ElevatedButton(
                  child: Text(widget.ans),
                  onPressed: update,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(color),
                  ),
                ))));
  }
}
