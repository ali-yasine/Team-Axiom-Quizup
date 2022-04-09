import 'package:flutter/material.dart';

// test
class Timer extends StatefulWidget {
  late final int timeTaken;
  final Alignment alignment;
  final int time;
  final VoidCallback onFinish;
  late AnimationController controller;
  bool hasFinished = false;
  Timer(
      {Key? key,
      required this.alignment,
      required this.time,
      required this.onFinish})
      : super(key: key);
  void stop() {
    hasFinished = true;
  }

  void getTime() {
    if (!hasFinished) {
      stop();
    }
  }

  @override
  State<StatefulWidget> createState() => TimerState();
}

//TickerProviderStateMixin needed for class that handles animations
class TimerState extends State<Timer> with TickerProviderStateMixin {
  void setupController() {
    widget.controller = AnimationController(
      vsync: this, //always needed
      duration: Duration(seconds: widget.time),
    )..addListener(() {
        setState(() {});
      });
    widget.controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        widget.hasFinished = true;
        widget.timeTaken = widget.time;
        widget.controller.stop();
        widget.onFinish();
      }
    });
    widget.controller.addListener(() {
      if (widget.hasFinished == true) {
        widget.timeTaken = timeElapsed();
        widget.controller.stop();
      }
    });
  }

  void start() {
    if (!widget.controller.isAnimating && !widget.hasFinished) {
      widget.controller.reverse(from: widget.time.toDouble());
    }
  }

  @override
  void initState() {
    setupController();
    super.initState();
  }

  int timeElapsed() {
    return widget.controller.lastElapsedDuration!.inSeconds.toInt();
  }

  @override
  Widget build(BuildContext context) {
    start();
    var size = MediaQuery.of(context).size;
    return Container(
      child: RotatedBox(
        quarterTurns: -1,
        child: Container(
            color: const Color.fromRGBO(245, 219, 78, 200),
            child: ClipRRect(
                //used to make circular borders
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  color: const Color.fromRGBO(245, 219, 78, 20),
                  value: widget.controller.value,
                  //1
                  semanticsLabel: 'Timer',
                )),
            width: size.height,
            height: 20),
      ),
      alignment: widget.alignment,
    );
  }
}
