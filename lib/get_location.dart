import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'get_weather.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({Key? key}) : super(key: key);

  @override
  State<GetLocation> createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  String? latitude;
  String? longitude;
  Future<void> getCurrentLocation() async {
    await Geolocator.requestPermission();
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;
    latitude = lat.toString();
    longitude = long.toString();
    print('$position');
  }

  Future<void> locationButton() async {
    await getCurrentLocation();
    GetWeather instance = GetWeather(
        latitude: latitude as String, longitude: longitude as String, city: "");
    await instance.getWeather();
    setState(() {
      Navigator.pushReplacementNamed(context, '/home',
          arguments: instance.weatherData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        title: Text(
          'Weather App',
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/home.png'), fit: BoxFit.fill)),
        child: Center(
          child: RaisedButton.icon(
            elevation: 10,
            color: Colors.grey[600],
            onPressed: locationButton,
            icon: Icon(Icons.location_on_outlined),
            label: Text(
              'Get Location',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
