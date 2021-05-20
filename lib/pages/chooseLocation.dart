import 'package:flutter/material.dart';
import 'package:worldtimeapp/services/worldTime.dart';

class ChooseLoc extends StatefulWidget {
  @override
  _ChooseLocState createState() => _ChooseLocState();
}

class _ChooseLocState extends State<ChooseLoc> {
  List<WorldTime> locations = WorldTime.getKnownTimes();

  void updateTime(int index, BuildContext context) async {
    showLoadingDialog(context);
    WorldTime chosenTime = locations[index];
    await chosenTime.generateTime();
    Navigator.pop(context); //Pop Loading Dialog Off screen.

    if (chosenTime.getSatus()) {
      Navigator.pop(context, chosenTime.getMapProperties());
    } else {
      showErrorDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Location"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.flag),
                title: Text("${locations[index].getLoc()}"),
                onTap: () async => updateTime(index, context),
              ),
            );
          },
        ),
      ),
    );
  }
}

void showErrorDialog(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text(
        "This time for the location is unavailable.Please try again later"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
    barrierDismissible: false,
  );
}

void showLoadingDialog(BuildContext context) {
  Widget loading = AlertDialog(
    title: Text(
      "Location Time is Loading",
    ),
    content: Text("Please Wait..."),
  );

  showDialog(
    context: context,
    builder: (context) => loading,
    barrierDismissible: false,
  );
}
