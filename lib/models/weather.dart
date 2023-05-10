Map<int, String> weatherMap = {
  0: "Clear sky",
  1: "Mainly clear",
  2: "Partly cloudy",
  3: "Overcast",
  45: "Fog and depositing rime fog",
  48: "Fog and depositing rime fog",
  51: "Drizzle: Light intensity",
  53: "Drizzle: Moderate intensity",
  55: "Drizzle: Dense intensity",
  56: "Freezing Drizzle: Light intensity",
  57: "Freezing Drizzle: Dense intensity",
  61: "Rain: Slight intensity",
  63: "Rain: Moderate intensity",
  65: "Rain: Heavy intensity",
  66: "Freezing Rain: Light intensity",
  67: "Freezing Rain: Heavy intensity",
  71: "Snow fall: Slight intensity",
  73: "Snow fall: Moderate intensity",
  75: "Snow fall: Heavy intensity",
  77: "Snow grains",
  80: "Rain showers: Slight intensity",
  81: "Rain showers: Moderate intensity",
  82: "Rain showers: Violent intensity",
  85: "Snow showers: Slight intensity",
  86: "Snow showers: Heavy intensity",
  95: "Thunderstorm: Slight or moderate",
  96: "Thunderstorm with slight hail",
  99: "Thunderstorm with heavy hail",
};

Map<int, String> weatherIcons = {
  0: "https://openweathermap.org/img/wn/01d.png",
  1: "https://openweathermap.org/img/wn/02d.png",
  2: "https://openweathermap.org/img/wn/03d.png",
  3: "https://openweathermap.org/img/wn/04d.png",
  45: "https://openweathermap.org/img/wn/50d.png",
  48: "https://openweathermap.org/img/wn/50d.png",
  51: "https://openweathermap.org/img/wn/10d.png",
  53: "https://openweathermap.org/img/wn/10d.png",
  55: "https://openweathermap.org/img/wn/09d.png",
  56: "https://openweathermap.org/img/wn/09d.png",
  57: "https://openweathermap.org/img/wn/09d.png",
  61: "https://openweathermap.org/img/wn/09d.png",
  63: "https://openweathermap.org/img/wn/09d.png",
  65: "https://openweathermap.org/img/wn/10d.png",
  66: "https://openweathermap.org/img/wn/13d.png",
  67: "https://openweathermap.org/img/wn/13d.png",
  71: "https://openweathermap.org/img/wn/13d.png",
  73: "https://openweathermap.org/img/wn/13d.png",
  75: "https://openweathermap.org/img/wn/13d.png",
  77: "https://openweathermap.org/img/wn/13d.png",
  80: "https://openweathermap.org/img/wn/09d.png",
  81: "https://openweathermap.org/img/wn/09d.png",
  82: "https://openweathermap.org/img/wn/09d.png",
  85: "https://openweathermap.org/img/wn/13d.png",
  86: "https://openweathermap.org/img/wn/13d.png",
  95: "https://openweathermap.org/img/wn/11d.png",
  96: "https://openweathermap.org/img/wn/11d.png",
  99: "https://openweathermap.org/img/wn/11d.png",
};

class Weather {
  const Weather(
    this.city,
    this.condition,
    this.currTemp,
    this.maxTemp,
    this.minTemp,
    this.nextWeek,
    this.rain,
    this.sunrise,
    this.sunset,
    this.windSpd,
  );
  final String city;
  final String currTemp;
  final String maxTemp;
  final String minTemp;
  final String windSpd;
  final String sunrise;
  final String sunset;
  final String rain;
  final Map<String, int> nextWeek;
  final int condition;
}
