import 'package:flutter/material.dart';
import 'package:worldtimeapp/pages/chooseLocation.dart';
import 'package:worldtimeapp/pages/home.dart';
import 'package:worldtimeapp/pages/loadingScreen.dart';

void main() {
  runApp(WorldTime());
}

class WorldTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'World Time App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoadingScreen(),
          '/home': (context) => Home(),
          '/chLoc': (context) => ChooseLoc()
        });
  }
}
