import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app_flutter/models/weather.dart';
import 'package:weather_app_flutter/widgets/daily_weather.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<Weather> _weather;

  @override
  void initState() {
    super.initState();
    _getCities("Lj");
    _weather = _getInfo("46.05", "14.51", "Ljubljana");
  }

  Future<Map<String, List<String>>> _getCities(String city) async {
    final url = Uri.https('geocoding-api.open-meteo.com', "/v1/search", {
      "name": city,
      "count": "10",
      "language": "en",
      "format": "json",
    });
    //throw Exception('An error occured!');
    var res = await http.get(url);
    if (res.statusCode >= 400) {
      throw Exception();
    }

    if (res.body == 'null') {
      return {};
    }
    final Map<String, dynamic> listData = json.decode(res.body);

    //print(url);
    //print(listData);

    return {};
    // setState(() {
    //   _groceryItems = loadedItems;
    //   _isLoading= false;
    // });
    //return loadedItems;
  }

  Future<Weather> _getInfo(String lat, String long, String city) async {
    final url = Uri.https("api.open-meteo.com", "/v1/forecast", {
      "latitude": lat,
      "longitude": long,
      "hourly": "temperature_2m",
      "daily":
          "weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_sum,windspeed_10m_max",
      "windspeed_unit": "ms",
      "current_weather": "true",
      "timezone": "Europe/Berlin",
    });

    final res = await http.get(url);

    if (res.statusCode >= 400 || res.body == 'null') {
      throw Exception();
    }

    final Map<String, dynamic> listData = json.decode(res.body);
    final daily = listData["daily"];
    final current = listData["current_weather"];

    return Weather(
      city,
      current["weathercode"],
      current["temperature"].toString(),
      daily["temperature_2m_max"][0].toString(),
      daily["temperature_2m_min"][0].toString(),
      [],
      daily["precipitation_sum"][0].toString(),
      daily["sunrise"][0],
      daily["sunset"][0],
      current["windspeed"].toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather"),
      ),
      body: FutureBuilder(
        future: _weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 14,
              ),
              Text(
                snapshot.data!.city,
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
                    Image.asset("assets/images/cloudy.png"),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${snapshot.data!.currTemp}°C",
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          weatherMap[snapshot.data!.condition]!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${snapshot.data!.maxTemp}°C",
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Text(
                              "Max",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "${snapshot.data!.minTemp}°C",
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Text(
                              "Min",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${snapshot.data!.windSpd}m/s",
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Text(
                              "Wind",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "${snapshot.data!.rain}%",
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Text(
                              "Rain",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.sunrise
                                  .substring(snapshot.data!.sunrise.length - 5),
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Text(
                              "Sunrise",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              snapshot.data!.sunset
                                  .substring(snapshot.data!.sunset.length - 5),
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Text(
                              "Sunset",
                              style: TextStyle(color: Colors.white),
                            ),
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
          );
        },
      ),
    );
  }
}
