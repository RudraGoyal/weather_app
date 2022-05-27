import 'package:flutter/material.dart';
import 'get_weather.dart';
import 'get_location.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  var textColor;
  var time;
  var sunsetTime;
  var isDaytime;
  var dayNight;
  var imageUrl;
  var city;
  String? weatherType;
  Map? weatherData;

  Widget build(BuildContext context) {
    weatherData = weatherData == null
        ? ModalRoute.of(context)?.settings.arguments as Map
        : weatherData;
    sunsetTime = weatherData!["sys"]["sunset"];
    time = weatherData!["dt"];
    weatherType = weatherData!["weather"][0]["main"];
    isDaytime = time > sunsetTime ? false : true;
    dayNight = isDaytime ? "Day" : "Night";
    textColor =
        isDaytime && weatherType != "Clouds" ? Colors.black : Colors.white;

    if (isDaytime && weatherType == "Clear") imageUrl = "clear_day";
    if (!isDaytime && weatherType == "Clear") imageUrl = "clear_night";
    if (weatherType == "Clouds") imageUrl = "cloudy";
    if (weatherType == "Rainy") imageUrl = "rainy";

    if (weatherType == "Clouds") weatherType = "Cloudy";

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/$imageUrl.png'),
            fit: BoxFit.cover,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(30),
                child: Text(
                  "$weatherType\n$dayNight",
                  style: TextStyle(
                      color: textColor,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    labelText: 'Change Location',
                    labelStyle: TextStyle(color: textColor),
                    hintText: 'Enter City...',
                    hintStyle: TextStyle(color: textColor),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: textColor, width: 3)),
                    icon: Icon(
                      Icons.search,
                      color: textColor,
                      size: 30,
                    ),
                  ),
                  onSubmitted: (value) async {
                    city = value;
                    print(city);
                    GetWeather instance =
                        GetWeather(latitude: '', longitude: '', city: city);
                    await instance.getWeather();
                    weatherData = instance.weatherData as Map;

                    setState(() {
                      Home();
                    });
                  },
                ),
              )),
              Container(
                child: Row(children: [
                  Container(
                    // main temperature
                    margin: EdgeInsets.only(bottom: 30),
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Text(
                          '${weatherData!["name"]}, ${weatherData!["sys"]["country"]}',
                          style: TextStyle(fontSize: 15, color: textColor),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${(weatherData!["main"]["temp"] - 273.15).round()}°C',
                          style: TextStyle(
                              fontSize: 70,
                              color: textColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'feels like ${(weatherData!["main"]["feels_like"] - 273.15).round()}°C',
                          style: TextStyle(color: textColor),
                        ),
                      ],
                    ),
                  ), //main temperature
                  Container(
                    //Extra Data

                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.thermostat,
                                color: textColor,
                              ),
                              Text(
                                "Min. Temperature: ${(weatherData!["main"]["temp_min"] - 273).round()}°C",
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.thermostat,
                                color: textColor,
                              ),
                              Text(
                                "Max. Temperature: ${(weatherData!["main"]["temp_max"] - 273).round()}°C",
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.air,
                                color: textColor,
                              ),
                              Text(
                                "Wind Speed: ${weatherData!["wind"]["speed"]} km/h",
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.water_drop,
                                color: textColor,
                              ),
                              Text(
                                "Humidity: ${weatherData!["main"]["humidity"]} %",
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                        ]), //Extra Data
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
