import 'package:flutter/material.dart';
import 'package:weather_app/get_location.dart';
import 'home.dart';
import 'choose_location.dart';

void main() {
  runApp(MaterialApp(
    title: 'Weather App',
    routes: {
      '/': (context) => GetLocation(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation(),
    },
  ));
}
