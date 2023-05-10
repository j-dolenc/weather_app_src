import 'package:flutter/material.dart';
import 'package:weather_app_flutter/models/weather.dart';

class TempCondition extends StatelessWidget {
  const TempCondition({
    super.key,
    required this.condition,
    required this.currTemp,
  });

  final String currTemp;
  final int condition;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$currTemp°C",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white70,
                fontSize: 60,
              ),
        ),
        Text(
          weatherMap[condition]!,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white70,
                fontSize: 24,
              ),
        ),
      ],
    );
  }
}
