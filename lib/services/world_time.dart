import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  String location; //notation name
  String flag; //url to an asset flag icon
  String url; // location url
  late String time; // time in that location
  late bool isDaytime;

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
  });

  Future<void> getTime() async {
    var response = await http.get(
      Uri.parse('http://worldtimeapi.org/api/timezone/$url'),
    );
    // print(response.body);

    try {
      Map data = jsonDecode(response.body);
      // print(data);

      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      DateTime now = DateTime.parse(datetime);

      now = now.add(Duration(hours: int.parse(offset.substring(1, 3))));

      // set time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = ' could not get the time';
    }
  }
}
