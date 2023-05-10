import 'package:flutter/material.dart';
import 'package:weather_app_flutter/models/weather.dart';

class DailyWeather extends StatelessWidget {
  const DailyWeather({
    super.key,
    required this.condition,
    required this.date,
  });

  final int condition;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(weatherIcons[condition]!),
        Text(date),
      ],
    );
  }
}
