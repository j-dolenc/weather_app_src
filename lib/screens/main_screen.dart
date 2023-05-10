import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:weather_app_flutter/models/weather.dart';
import 'package:weather_app_flutter/widgets/city.dart';
import 'package:weather_app_flutter/widgets/daily_weather.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String searchValue = '';
  String lat = "46.05";
  String long = "14.51";
  late Future<Weather> _weather;
  List<List<String>> _cities = List.generate(
      3, (i) => List.filled(10, "", growable: false),
      growable: false);

  @override
  void initState() {
    super.initState();
    _weather = _getInfo("46.05", "14.51", "Ljubljana");
  }

  Future<List<String>> _getCityLatLong(String city) async {
    //print(_cities);
    final url = Uri.https('geocoding-api.open-meteo.com', "/v1/search", {
      "name": city,
      "count": "1",
      "language": "en",
      "format": "json",
    });
    //throw Exception('An error occured!');
    var res = await http.get(url);
    if (res.statusCode >= 400) {
      throw Exception();
    }

    if (res.body == 'null') {
      return [] as List<String>;
    }

    final Map<String, dynamic> listData = json.decode(res.body);
    final results = listData["results"] as List;

    var latLong = [
      results[0]["latitude"].toString(),
      results[0]["longitude"].toString()
    ];

    print(latLong);

    return latLong;
  }

  Future<List<String>> _getCityNames(String city) async {
    //print(_cities);
    final url = Uri.https('geocoding-api.open-meteo.com', "/v1/search", {
      "name": city,
      "count": "10",
      "language": "en",
      "format": "json",
    });
    //throw Exception('An error occured!');
    var res = await http.get(url);
    if (res.statusCode >= 400) {
      print(res.statusCode);
      throw Exception();
    }

    if (res.body == 'null') {
      return [] as List<String>;
    }
    final Map<String, dynamic> listData = json.decode(res.body);
    if (listData["results"] == null) {
      return [];
    }
    final results = listData["results"] as List;

    List<String> cities = List.filled(results.length, "");

    for (var i = 0; i < results.length; i++) {
      cities[i] = results[i]["name"];
    }
    print(cities);
    //print(url);

    return cities;
    // setState(() {
    //   _groceryItems = loadedItems;
    //   _isLoading= false;
    // });
    //return loadedItems;
  }

  Future<Weather> _getInfo(String lat, String long, String city) async {
    final Map<String, int> weekly = {};
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
      print(res.statusCode);
      throw Exception();
    }

    final Map<String, dynamic> listData = json.decode(res.body);

    final daily = listData["daily"];
    final current = listData["current_weather"];

    for (var i = 0; i < 7; i++) {
      weekly[daily["time"][i]] = daily["weathercode"][i];
    }

    return Weather(
      city,
      current["weathercode"],
      current["temperature"].toString(),
      daily["temperature_2m_max"][0].toString(),
      daily["temperature_2m_min"][0].toString(),
      weekly,
      daily["precipitation_sum"][0].toString(),
      daily["sunrise"][0],
      daily["sunset"][0],
      current["windspeed"].toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text('Weather'),
        onSearch: (value) => {
          setState(() {
            searchValue = value;
          })
        },
        openOverlayOnSearch: false,
        onSuggestionTap: (data) async {
          var latLong = await _getCityLatLong(data);

          setState(() {
            _weather = _getInfo(latLong[0], latLong[1], data);
          });
        },
        asyncSuggestions: (value) async {
          if (value.length <= 3) {
            return [];
          }
          //var city = await _getCityNames(value);
          //print(city);
          return await _getCityNames(value);
        },
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
              City(city: snapshot.data!.city),
              const SizedBox(
                height: 14,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(weatherIcons[snapshot.data!.condition]!),
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
                  children: snapshot.data!.nextWeek.entries.map((e) {
                    DateTime currentDate = DateTime.now();
                    if (currentDate.day.toString() ==
                        e.key.substring(e.key.length - 2)) {
                      return DailyWeather(condition: e.value, date: "Today");
                    }
                    var day = DateFormat('EEEE').format(DateTime.parse(e.key));

                    return DailyWeather(condition: e.value, date: day);
                  }).toList(),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
