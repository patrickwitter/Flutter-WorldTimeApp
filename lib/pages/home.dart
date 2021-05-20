import 'package:flutter/material.dart';

Map data = {};

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    data = (data.isEmpty) ? ModalRoute.of(context).settings.arguments : data;

    String timePicture = (data["isDay"]) ? "DayImage.jpg" : "NightImage.jpg";

    void getNewLoc() async {
      dynamic result = await Navigator.pushNamed(context, "/chooseLoc");
      setState(() {
        if (result is Map) {
          data = result;
        }
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Home "),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "assets/images/$timePicture",
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: HomeBody(
              getNewLoc: getNewLoc,
            ),
          ),
        ));
  }
}

class HomeBody extends StatelessWidget {
  final Function getNewLoc;
  const HomeBody({Key key, @required this.getNewLoc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        TextButton.icon(
          onPressed: () => getNewLoc(),
          icon: Icon(
            Icons.edit_location,
            size: 50,
          ),
          label: Text(
            "Edit Country Location",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          data["location"],
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blue[500],
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          data["time"],
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blue[500],
            fontWeight: FontWeight.bold,
            fontSize: 50,
          ),
        ),
      ],
    );
  }
}
