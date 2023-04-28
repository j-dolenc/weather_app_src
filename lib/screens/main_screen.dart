import 'package:flutter/material.dart';
import 'package:weather_app_flutter/widgets/daily_weather.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 14,
          ),
          Text(
            "Ljubljana, Slovenia",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 40,
                ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 14,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("aaa"),
                Column(
                  children: const [
                    Text("21stopinj"),
                    Text("Cloudy"),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: const [
                        Text("25"),
                        Text("Max"),
                        Text("15?"),
                        Text("Min"),
                      ],
                    ),
                    Column(
                      children: const [
                        Text("3m/w"),
                        Text("Wind"),
                        Text("12%"),
                        Text("Rain"),
                      ],
                    ),
                    Column(
                      children: const [
                        Text("5:30"),
                        Text("Sunrise"),
                        Text("18:30"),
                        Text("Sunset"),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                DailyWeather(),
                DailyWeather(),
                DailyWeather(),
                DailyWeather(),
                DailyWeather(),
                DailyWeather(),
                DailyWeather(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
