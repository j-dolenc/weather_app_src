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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$maxTemp°C",
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              "Max",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white70,
                  ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 14),
            ),
            Text(
              "$minTemp°C",
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              "Min",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
        const SizedBox(
          width: 28,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$windSpd m/s",
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              "Wind",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white70,
                  ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 14),
            ),
            Text(
              "$rain%",
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              "Rain",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
        const SizedBox(
          width: 28,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sunrise.substring(sunrise.length - 5),
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              "Sunrise",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white70,
                  ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 14),
            ),
            Text(
              sunset.substring(sunset.length - 5),
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              "Sunset",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        )
      ],
    );
  }
}
