import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

// This class's purpose is the retrieve the time either requested by the programmer
// or the user.

class WorldTime {
  // final  String defText = "UNKNOWN"; // This is default text

  String _location; // location name for UI
  String _time; // the time in that location
  String _flag; // url to an asset flag icon
  String _url; // location url for api endpoint
  bool _isDaytime; // true or false if daytime or not

  static Set<WorldTime> _knownTimes = {};

  // This constructor is used when the country is not already stored
  WorldTime({String url, String loc}) {
    this._url = url;
    this._location = loc;
  }

  // This constructor is used when the country is already stored
  WorldTime.knownLoc({String location}) {
    this._location = location;
  }

  Future<String> generateTime() async {
    String defaultLoc = "http://worldtimeapi.org/api/timezone/$_url";

    try {
      Response response = await get(Uri.parse(defaultLoc));
      // print(response.body);

      Map dateData = jsonDecode(response.body);

      String offset = dateData["utc_offset"];

      DateTime currTime = DateTime.parse(dateData["datetime"]);
      // print(currTime);

      //Adjusting for UTC offset
      currTime = _adjustOffset(time: currTime, offset: offset);

      // Formating dateTime to a more readable format and time and is isdaytime paramter
      this._time = DateFormat.jm().format(currTime);
      // print("$this._time");

      this._isDaytime = _calcDayTime(this._time);

      _knownTimes.add(this);

      return this._time;
    } catch (e) {
      print("Error Occurred $e");
      return "An error had occured";
    }
  }

  String getTime() => this._time;
  String getLoc() => this._location;
  bool getIsDay() => this._isDaytime;

// This function adjusts the orginal time retrieved from the http request
// with the offset value provided from the request as well
// Depending on the sign of the offset the time is offset
// is either added or substracted from the original time.
  DateTime _adjustOffset({DateTime time, String offset}) {
    var offsetSign = offset[0];
    int offsetHr = int.parse(offset.substring(1, 3));
    int offsetMin = int.parse(offset.substring(4, 6));

    // print(
    //     " Offset Hr $offsetHr Sign $sign Offset Min $offsetMin SignBool ${sign == "-"}");

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

    // print("TimeHR-$timeHr TimeofDay-$timeOfDay");

    bool isDay = (timeOfDay == "PM")
        ? ((timeHr >= 1 && timeHr <= 5) || timeHr == 12)
        : (timeHr >= 6 && timeHr <= 11);

    // print(isDay);

    return isDay;
  }

  List<WorldTime> getKnownTimes() => _knownTimes.toList();

  @override
  String toString() {
    return "Location: ${this._location}; Time: ${this._time}; ";
  }
}
