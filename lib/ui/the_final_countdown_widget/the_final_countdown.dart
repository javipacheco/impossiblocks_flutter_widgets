import 'dart:async';
import 'package:flutter/material.dart';
import 'package:impossiblocks_flutter_widgets/ui/the_final_countdown_widget/the_final_countdown_screen.dart';

class TheFinalCountdownWidget extends StatefulWidget {
  final GameStatus status;

  final int seconds;

  final Function onCountdownStart;

  final Function onTimeEnd;

  TheFinalCountdownWidget(
      {Key key,
      @required this.status,
      @required this.seconds,
      @required this.onCountdownStart,
      @required this.onTimeEnd})
      : super(key: key);

  _TheFinalCountdownWidgetState createState() =>
      _TheFinalCountdownWidgetState();
}

enum TheFinalCountdownStatus { IDLE, COUNTDOWN, CLOCK }

class _TheFinalCountdownWidgetState extends State<TheFinalCountdownWidget>
    with TickerProviderStateMixin {
  static double roundedLayout = 35.0;

  static double startButtonHeight = 56.0;

  static const Color primaryColorDark = Color(0xFF07315A);

  static const Color boardBackground = Color(0xFFe0e0e0);

  static const Color colorTile1 = Color(0xff1976D2);

  Timer _timer;

  TheFinalCountdownStatus _status;

  int _countdown;

  AnimationController _controller;
  Animation<double> _animation;

  AnimationController _scaleController;
  Animation<double> _scaleAnimation;

  bool _fadeCompleted = false;

  @override
  void initState() {
    _timer = null;
    _status = TheFinalCountdownStatus.IDLE;
    _countdown = 3;
    _fadeCompleted = false;

    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation = CurveTween(curve: Curves.easeIn).animate(_controller);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _fadeCompleted = true;
        });
      }
    });

    _scaleController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _scaleAnimation =
        CurveTween(curve: Curves.easeOut).animate(_scaleController);

    super.initState();
  }

  void onCountDown() {
    widget.onCountdownStart();
    setState(() {
      _status = TheFinalCountdownStatus.COUNTDOWN;
      _countdown = 3;
      _scaleController.reset();
      _scaleController.forward();
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _countdown = _countdown - 1;
          _scaleController.reset();
          _scaleController.forward();
          if (_countdown < 0) {
            _controller.reset();
            _controller.forward();
            _timer.cancel();
            _status = TheFinalCountdownStatus.CLOCK;
            widget.onTimeEnd();
          }
        });
      });
    });
  }

  @override
  void didUpdateWidget(TheFinalCountdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status == GameStatus.IDLE) {
      setState(() {
        _fadeCompleted = false;
        _status = TheFinalCountdownStatus.IDLE;
      });
    }
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    _controller.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  BoxDecoration _boxDecoration(Color color) {
    return BoxDecoration(
        shape: BoxShape.rectangle,
        color: color,
        borderRadius: BorderRadius.circular(roundedLayout));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_status == TheFinalCountdownStatus.IDLE) onCountDown();
      },
      child: AnimatedContainer(
        constraints: BoxConstraints.expand(
            height: startButtonHeight,
            width: _status == TheFinalCountdownStatus.IDLE ? 200 : 300),
        curve: Curves.easeInOut,
        decoration: _boxDecoration(_status == TheFinalCountdownStatus.IDLE
            ? primaryColorDark
            : boardBackground),
        duration: Duration(milliseconds: 500),
        child: _status == TheFinalCountdownStatus.IDLE
            ? Center(
                child: Text("Start",
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w700,
                        fontSize: 26.0)),
              )
            : _status == TheFinalCountdownStatus.COUNTDOWN
                ? Center(
                    child: ScaleTransition(
                      alignment: Alignment.center,
                      scale: _scaleAnimation,
                      child: Text(
                        _countdown == 0 ? "GO!" : _countdown.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 32.0,
                            color: primaryColorDark),
                      ),
                    ),
                  )
                : FadeTransition(
                    opacity: _animation,
                    child: Stack(children: <Widget>[
                      AnimatedContainer(
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 200),
                          constraints: BoxConstraints.expand(
                              height: startButtonHeight,
                              width: _fadeCompleted
                                  ? startButtonHeight +
                                      (widget.seconds *
                                              (300 - startButtonHeight)) /
                                          maxTime
                                  : startButtonHeight),
                          decoration: _boxDecoration(Colors.green)),
                      Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints.expand(
                              height: startButtonHeight,
                              width: startButtonHeight),
                          decoration: _boxDecoration(colorTile1),
                          child: Text(getTimeFormatted(widget.seconds),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                  color: Colors.white)))
                    ])),
      ),
    );
  }

  String getTimeFormatted(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;
    return "$m:${s.toString().padLeft(2, "0")}";
  }
}
