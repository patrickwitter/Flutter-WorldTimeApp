// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:worldtimeapp/services/worldTime.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String loadText = "loading";
  Widget loadPic = ErrPic();

  void setTime() async {
    WorldTime time = WorldTime(url: "America/Jamica", location: "Jamaica");

    // WorldTime time = WorldTime.getKnownTimes()[1];
    // print(time);

    await time.generateTime();

    if (time.getSatus()) {
      Navigator.pushReplacementNamed(context, '/home',
          arguments: time.getMapProperties());
    } else {
      setState(() => loadPic = ErrPic());
    }
  }

  @override
  void initState() {
    super.initState();
    setTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: loadPic,
      ),
    );
  }
}

class ErrPic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("worldtimeapp/assets/images/brokenApp.png"),
          ),
        ),
      ),
    );
  }
}

class SpinImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCube(
      color: Colors.blue,
      size: 100,
    );
  }
}
