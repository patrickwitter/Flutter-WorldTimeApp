import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String loadText = "loading";

  void getTime() async {
    String defaultLoc = "http://worldtimeapi.org/api/timezone/America/Jamaica";
    String testLoc = "https://jsonplaceholder.typicode.com/todos/1";
    try {
      Response response = await get(Uri.parse(defaultLoc));

      print(response.body);
    } catch (e) {
      setState(() {
        loadText = "An error had occured $e";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTime();
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
