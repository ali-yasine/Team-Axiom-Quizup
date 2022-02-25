import 'package:flutter/material.dart';

class timer extends AnimatedWidget {
  timer({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;
  @override
  Widget build(BuildContext context) {
    return Text(
      animation.value.toString(),
      style: const TextStyle(fontSize: 30),
    );
  }
}
