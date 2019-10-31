import 'package:flutter/material.dart';

class SwipeDetector extends StatefulWidget {
  final Widget child;

  final Function(SwipeMove) onSwipe;

  SwipeDetector(
      {Key key,
      @required this.child,
      @required this.onSwipe})
      : super(key: key);

  _SwipeDetectorState createState() => _SwipeDetectorState();
}

class _SwipeDetectorState extends State<SwipeDetector> {
  Offset _swipe;

  double _x;

  double _y;

  @override
  void initState() {
    _swipe = Offset.zero;
    _x = 0;
    _y = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (gesture) {
        RenderBox object = context.findRenderObject();
        Offset _localPosition = object.globalToLocal(gesture.globalPosition);
        setState(() {
          _x = _localPosition.dx;
          _y = _localPosition.dy;
          _swipe = Offset.zero;
        });
      },
      onPanUpdate: (gesture) {
        setState(() {
          _swipe = _swipe + gesture.delta;
        });
      },
      onPanEnd: (gesture) {
        setState(() {
          if ((_swipe.dx.abs() > _swipe.dy.abs() ? _swipe.dx.abs() : _swipe.dy.abs()) > 30) {
            Move horizontal = _swipe.dx > 0 ? Move.RIGHT : Move.LEFT;
            Move vertical = _swipe.dy > 0 ? Move.DOWN : Move.UP;
            Move move = _swipe.dx.abs() > _swipe.dy.abs() ? horizontal : vertical;
            widget.onSwipe(SwipeMove(move: move, x: _x, y: _y));
          }
          _swipe = Offset.zero;
        });
      },
      child: widget.child,
    );
  }
}

enum Move { UP, DOWN, LEFT, RIGHT, IDLE }

class SwipeMove {
  final Move move;

  final double x;

  final double y;

  SwipeMove({@required this.move, @required this.x, @required this.y});

  factory SwipeMove.empty() {
    return SwipeMove(move: Move.IDLE, x: 0, y: 0);
  }

  @override
  String toString() {
    return "SwipeMove{move: $move, x: $x, column: $y}";
  }
}
