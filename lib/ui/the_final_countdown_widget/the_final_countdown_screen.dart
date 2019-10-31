import 'dart:async';

import 'package:flutter/material.dart';
import 'package:impossiblocks_flutter_widgets/ui/the_final_countdown_widget/the_final_countdown.dart';

enum GameStatus { COUNTDOWN, PLAYING, IDLE }

const int maxTime = 20;

class TheFinalCountdownScreen extends StatefulWidget {
  TheFinalCountdownScreen({Key key}) : super(key: key);

  @override
  _TheFinalCountdownScreenState createState() =>
      _TheFinalCountdownScreenState();
}

class _TheFinalCountdownScreenState extends State<TheFinalCountdownScreen> {
  Timer _timerGame;

  GameStatus gameStatus;

  int seconds;

  @override
  void initState() {
    gameStatus = GameStatus.IDLE;
    seconds = maxTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Final Countdown Widget"),
      ),
      body: buildCompleteWidget(),
    );
  }

  Center buildCompleteWidget() {
    return Center(
      child: TheFinalCountdownWidget(
        status: gameStatus,
        seconds: seconds,
        onCountdownStart: () {
          setState(() {
            seconds = maxTime;
            gameStatus = GameStatus.COUNTDOWN;
          });
        },
        onTimeEnd: () {
          stopTimeGame();
          setState(() {
            gameStatus = GameStatus.PLAYING;
            _timerGame = startTimeGame();
          });
        },
      ),
    );
  }

  Timer startTimeGame() {
    return Timer.periodic(Duration(seconds: 1), (timer) {
      if (gameStatus == GameStatus.PLAYING) {
        setState(() {
          seconds = seconds - 1;
        });
        if (seconds <= 0) {
          timer.cancel();
          gameStatus = GameStatus.IDLE;
        }
      }
    });
  }

  void stopTimeGame() {
    if (_timerGame != null) {
      _timerGame.cancel();
      _timerGame = null;
    }
  }
}


