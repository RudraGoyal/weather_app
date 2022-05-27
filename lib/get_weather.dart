import 'package:http/http.dart';
import 'dart:convert';

class GetWeather {
  String latitude;
  String longitude;
  String city;
  Map? weatherData;

  GetWeather(
      {required this.latitude, required this.longitude, required this.city});
  Future<void> getWeather() async {
    Response response;
    if (city == '') {
      response = await get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=df7c23e32a01463b1fa0ef91a34f5890'));
    } else {
      response = await get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=df7c23e32a01463b1fa0ef91a34f5890'));
    }
    print(response.body);
    weatherData = await jsonDecode(response.body);
  }
}
