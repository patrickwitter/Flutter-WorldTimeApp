import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = (data.isEmpty) ? ModalRoute.of(context).settings.arguments : data;
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
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, "/chooseLoc");
                  setState(() {
                    if (result is Map) {
                      data = result;
                      // print(data);
                    }
                  });
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
