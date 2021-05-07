import 'dart:convert';

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

      // print(response.body);

      Map dateData = jsonDecode(response.body);

      String offset = dateData["utc_offset"];

      DateTime currTime = DateTime.parse(dateData["datetime"]);
      // print(currTime);

      currTime = adjustOffset(time: currTime, offset: offset);
    } catch (e) {
      setState(() {
        loadText = "An error had occured $e";
        print("Error Occurred");
      });
    }
  }

  DateTime adjustOffset({DateTime time, String offset}) {
    var sign = offset[0];
    int offsetHr = int.parse(offset.substring(1, 3));
    int offsetMin = int.parse(offset.substring(4, 6));

    print(
        " Offset Hr $offsetHr Sign $sign Offset Min $offsetMin SignBool ${sign == "-"}");

    return (sign == "-")
        ? time.subtract(Duration(hours: offsetHr, minutes: offsetMin))
        : time.add(Duration(hours: offsetHr, minutes: offsetMin));
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
