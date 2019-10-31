import 'package:flutter/material.dart';
import 'package:impossiblocks_flutter_widgets/ui/swipe_detector_widget/swipe_detector.dart';

class SwipeDetectorScreen extends StatefulWidget {
  SwipeDetectorScreen({Key key}) : super(key: key);

  @override
  _SwipeDetectorScreenState createState() => _SwipeDetectorScreenState();
}

class _SwipeDetectorScreenState extends State<SwipeDetectorScreen> {
  SwipeMove _swipeMove;

  String getSwipeText() {
    if (_swipeMove == null) {
      return "No swipe";
    } else {
      return "${_swipeMove.move.toString().substring(5)} (${_swipeMove.x.round()}x${_swipeMove.y.round()})";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swipe Detector Widget"),
      ),
      body: SwipeDetector(
        onSwipe: (move) {
          setState(() {
            _swipeMove = move;
          });
        },
        child: Container(
          color: Colors.white,
          constraints: BoxConstraints.expand(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Do a swipe", style: TextStyle(fontSize: 22),),
              ), Text(getSwipeText(), style: TextStyle(fontSize: 28),)],
            ),
          ),
        ),
      ),
    );
  }
}
