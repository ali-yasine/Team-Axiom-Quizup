import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  late final int timeTaken;
  final Alignment alignment;
  final int time;
  final VoidCallback onFinish;
  bool _stop = false;
  Timer(
      {Key? key,
      required this.alignment,
      required this.time,
      required this.onFinish})
      : super(key: key);
  void stop() {
    _stop = true;
  }

  @override
  State<StatefulWidget> createState() => _timerState();
}

//TickerProviderStateMixin needed for class that handles animations
class _timerState extends State<Timer> with TickerProviderStateMixin {
  late AnimationController _controller;
  void setupController() {
    _controller = AnimationController(
      vsync: this, //always needed
      duration: Duration(seconds: widget.time),
    )..addListener(() {
        setState(() {});
      });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        widget.timeTaken = timeElapsed();
        widget.onFinish();
      }
    });
    _controller.addListener(() {
      if (widget._stop == true) {
        widget.timeTaken = timeElapsed();
        _controller.stop();
      }
    });
  }

  void start() {
    if (!_controller.isAnimating && !widget._stop) {
      _controller.reverse(from: widget.time.toDouble());
    }
  }

  @override
  void initState() {
    setupController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int timeElapsed() {
    return _controller.lastElapsedDuration!.inSeconds.toInt();
  }

  @override
  Widget build(BuildContext context) {
    start();
    var size = MediaQuery.of(context).size;
    return Container(
      child: RotatedBox(
        quarterTurns: -1,
        child: SizedBox(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: _controller.value,
                  semanticsLabel: 'Timer',
                )),
            width: size.height,
            height: 20),
      ),
      alignment: widget.alignment,
    );
  }
}
