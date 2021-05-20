import 'package:flutter/material.dart';
import 'package:worldtimeapp/services/worldTime.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Widget loadPic = SpinImage();

  void setTime() async {
    WorldTime time = WorldTime(url: "America/Jamaica", location: "Jamaica");

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
    return Column(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/brokenApp.png"),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "Kindly Restart the App",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
            ),
          ),
        )
      ],
    );
  }
}

class SpinImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: SpinKitFadingCube(
        color: Colors.blue,
        size: 100,
      ),
    );
  }
}
