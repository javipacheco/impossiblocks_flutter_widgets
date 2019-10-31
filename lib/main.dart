import 'package:flutter/material.dart';
import 'package:impossiblocks_flutter_widgets/navigation/routes.dart';
import 'package:impossiblocks_flutter_widgets/ui/main/main_screen.dart';
import 'package:impossiblocks_flutter_widgets/ui/swipe_detector_widget/swipe_detector_screen.dart';
import 'package:impossiblocks_flutter_widgets/ui/the_final_countdown_widget/the_final_countdown_screen.dart';

void main() => runApp(ImpossiblocksWidgetsApp());

class ImpossiblocksWidgetsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Impossiblocks Widgets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Trench',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          //navigatorObservers: <NavigatorObserver>[observer],
          //debugShowCheckedModeBanner: false,
          title: "Impossiblocks Widgets",
          theme: ThemeData(
            fontFamily: 'Trench',
          ),
          routes: {
            Routes.home: (context) => MainScreen(),
            Routes.swipeDetector: (context) => SwipeDetectorScreen(),
            Routes.theFinalCountdown: (context) => TheFinalCountdownScreen(),
          },
        );
  }
}
