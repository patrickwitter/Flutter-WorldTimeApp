import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    String dataText =
        " Time - ${data["time"]}  Location - ${data["location"]} ";
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, "/chooseLoc");
                },
                icon: Icon(
                  Icons.edit_location,
                ),
                label: Text("Edit Country Location"),
              ),
              Text(
                dataText,
              ),
            ],
          ),
        ));
  }
}
