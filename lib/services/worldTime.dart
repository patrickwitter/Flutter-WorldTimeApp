import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

// This class's purpose is the retrieve the time either requested by the programmer
// or the user.

class WorldTime {
  String _location; // location name for UI
  String _time; // the time in that location
  String _flag; // url to an asset flag icon
  String _url; // location url for api endpoint
  bool _isDaytime; // true or false if daytime or not

  // This constructor is used when the country is not already stored
  WorldTime({String url}) {
    this._url = url;
  }

  // This constructor is used when the country is already stored
  WorldTime.knownLoc({String location}) {
    this._location = location;
  }

  Future<String> getTime() async {
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

      // Formating dateTime to a more readable format
      String formatDate = DateFormat.jm().format(currTime);
      // print("$formatDate");

      return formatDate;
    } catch (e) {
      print("Error Occurred $e");
      return "An error had occured";
    }
  }

  DateTime _adjustOffset({DateTime time, String offset}) {
    var sign = offset[0];
    int offsetHr = int.parse(offset.substring(1, 3));
    int offsetMin = int.parse(offset.substring(4, 6));

    // print(
    //     " Offset Hr $offsetHr Sign $sign Offset Min $offsetMin SignBool ${sign == "-"}");

    return (sign == "-")
        ? time.subtract(Duration(hours: offsetHr, minutes: offsetMin))
        : time.add(Duration(hours: offsetHr, minutes: offsetMin));
  }
}

class _Times {}
