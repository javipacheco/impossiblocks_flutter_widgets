import 'package:flutter/material.dart';
import 'package:impossiblocks_flutter_widgets/navigation/routes.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Impossiblocks Widgets"),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: MainContainer(),
    );
  }
}

class MainContainer extends StatelessWidget {
  const MainContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              height: 120.0,
              minWidth: double.infinity,
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text(
                "The Final Countdown Widget",
                style: new TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () => {
                Navigator.pushNamed(context, Routes.theFinalCountdown)
              },
              splashColor: Colors.blueAccent,
            ),
            MaterialButton(
              height: 120.0,
              minWidth: double.infinity,
              color: Colors.red,
              textColor: Colors.white,
              child: new Text(
                "Swipe Detector Widget",
                style: new TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () => {
                Navigator.pushNamed(context, Routes.swipeDetector)
              },
              splashColor: Colors.redAccent,
            )
          ],
        ),
      ),
    );
  }
}
