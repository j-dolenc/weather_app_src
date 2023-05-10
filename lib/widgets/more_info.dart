import 'package:flutter/material.dart';

class MoreInfo extends StatelessWidget {
  const MoreInfo({
    super.key,
    required this.maxTemp,
    required this.minTemp,
    required this.rain,
    required this.sunrise,
    required this.sunset,
    required this.windSpd,
  });

  final String maxTemp;
  final String minTemp;
  final String windSpd;
  final String rain;
  final String sunrise;
  final String sunset;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$maxTemp°C",
              style: const TextStyle(color: Colors.white70),
            ),
            const Text(
              "Max",
              style: TextStyle(color: Colors.white70),
            ),
            Text(
              "$minTemp°C",
              style: const TextStyle(color: Colors.white70),
            ),
            const Text(
              "Min",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
        const SizedBox(
          width: 28,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$windSpd m/s",
              style: const TextStyle(color: Colors.white70),
            ),
            const Text(
              "Wind",
              style: TextStyle(color: Colors.white70),
            ),
            Text(
              "${(double.parse(rain) * 10).floor().toString()}%",
              style: const TextStyle(color: Colors.white70),
            ),
            const Text(
              "Rain",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
        const SizedBox(
          width: 28,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sunrise.substring(sunrise.length - 5),
              style: const TextStyle(color: Colors.white70),
            ),
            const Text(
              "Sunrise",
              style: TextStyle(color: Colors.white70),
            ),
            Text(
              sunset.substring(sunset.length - 5),
              style: const TextStyle(color: Colors.white70),
            ),
            const Text(
              "Sunset",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        )
      ],
    );
  }
}
