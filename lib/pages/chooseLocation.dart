import 'package:flutter/material.dart';
import 'package:worldtimeapp/services/worldTime.dart';

class ChooseLoc extends StatefulWidget {
  @override
  _ChooseLocState createState() => _ChooseLocState();
}

class _ChooseLocState extends State<ChooseLoc> {
  List<WorldTime> location = WorldTime.getKnownTimes();
  @override
  Widget build(BuildContext context) {
    print(location);
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Location"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: location.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.flag),
                title: Text("${location[index].getLoc()}"),
                onTap: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
