import 'package:flutter/material.dart';
import 'package:worldtimeapp/services/worldTime.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String loadText = "loading";

  void setTime() async {
    WorldTime time = WorldTime(url: "America/Jamaica", location: "Jamaica");

    // WorldTime time = WorldTime.getKnownTimes()[1];
    // print(time);

    await time.generateTime();

    if (time.getSatus()) {
      Navigator.pushReplacementNamed(context, '/home',
          arguments: time.getMapProperties());
    } else {
      setState(() => loadText = '${time.getErrMess()}');
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
        child: Text(
          loadText,
        ),
      ),
    );
  }
}
