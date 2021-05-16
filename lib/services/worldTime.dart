import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

// This class's purpose is the retrieve the time either requested by the programmer
// or the user.

class WorldTime {
  // final  String defText = "UNKNOWN"; // This is default text

  String _location; // location name for UI
  String _time; // the time in that location
  String _url; // location url for api endpoint
  bool _isDaytime; // true or false if daytime or not

  bool _wasSucc = false; //Determines if Retrieval of time data was succeful
  String _errMess; // Error Message

  static Set<WorldTime> _knownTimes = {
    WorldTime(url: "America/Jamaica", location: "Jamaica"),
    WorldTime(url: "Europe/London", location: "London"),
    WorldTime(url: "Europe/Berlin", location: "Berlin"),
    WorldTime(url: "America/New_York", location: "New_York"),
    WorldTime(url: "Asia/Ho_Chi_Minh", location: "Ho_Chi_Minh"),
  };

  // This constructor is used when the country is not already stored
  WorldTime({@required String url, @required String location}) {
    this._url = url;
    this._location = location;
  }

  Future<void> generateTime() async {
    try {
      String apiLoc = "http://worldtimeapi.org/api/timezone/${this._url}";

      Response response = await get(Uri.parse(apiLoc));

      Map dateData = jsonDecode(response.body);

      String offset = dateData["utc_offset"];

      DateTime currTime = DateTime.parse(dateData["datetime"]);

      //Adjusting for UTC offset
      currTime = _adjustOffset(time: currTime, offset: offset);

      // Formating dateTime to a more readable format and time and is isdaytime paramter
      this._time = DateFormat.jm().format(currTime);

      this._isDaytime = _calcDayTime(this._time);

      this._wasSucc = true;
    } on FormatException catch (f) {
      print("Formatting Error Occured $f");
      this._errMess =
          "Their was a problem with our server. Kindly reload the app";
    } catch (e) {
      print("Error Occurred $e");
      this._errMess = "An error had occured";
    }
  }

  String getTime() => this._time;
  String getLoc() => this._location;
  bool getIsDay() => this._isDaytime;
  bool getSatus() => this._wasSucc;
  String getErrMess() => this._errMess;
  static List<WorldTime> getKnownTimes() => _knownTimes.toList();

// This function adjusts the orginal time retrieved from the http request
// with the offset value provided from the request as well
// Depending on the sign of the offset the time is offset
// is either added or substracted from the original time.
  DateTime _adjustOffset({DateTime time, String offset}) {
    var offsetSign = offset[0];
    int offsetHr = int.parse(offset.substring(1, 3));
    int offsetMin = int.parse(offset.substring(4, 6));

    return (offsetSign == "-")
        ? time.subtract(Duration(hours: offsetHr, minutes: offsetMin))
        : time.add(Duration(hours: offsetHr, minutes: offsetMin));
  }

  //returns whether it is day Time of not.
  // Daytime if time is between 6Am - 11Am or 12Pm - 5Pm
  bool _calcDayTime(String time) {
    int timeHr = int.parse(time.split(":")[0]); // The hour of the day eg. 12 -1

    String timeOfDay =
        time.split(" ")[1]; // The time indication of the day eg. AM or PM

    bool isDay = (timeOfDay == "PM")
        ? ((timeHr >= 1 && timeHr <= 5) || timeHr == 12)
        : (timeHr >= 6 && timeHr <= 11);

    return isDay;
  }

  @override
  String toString() {
    return "Location: ${this._location}; Time: ${this._time}; ";
  }

  Map getMapProperties() {
    return {
      "time": this.getTime(),
      "location": this.getLoc(),
      "isDay": this.getIsDay(),
      "worldTime": this,
    };
  }
}
