import 'package:flutter/material.dart';
import 'package:worldtimeapp/services/worldTime.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String loadText = "loading";

  void setTime() async {
    String time = await WorldTime(url: "America/Jamaica").getTime();

    setState(() => loadText = time);
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
