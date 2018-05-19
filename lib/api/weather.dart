import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:omppu_pad/utils/keychain.dart';

final keychain = new Keychain();

Future<List<DayForecast>> fetchWeatherForecast() async {
  final response = await http.get(
      "http://api.openweathermap.org/data/2.5/forecast?q=Helsinki,fi&APPID=${keychain.openWeatherMapAPIKey}");
  return dayForecastsFromJson(response.body);
}

List<DayForecast> dayForecastsFromJson(String jsonString) {
  var forecast = new List<DayForecast>();
  Map decoded = json.decode(jsonString);
  decoded['list'].forEach((day) {
    var main = day['main'];
    var weather = day['weather'][0];
    forecast.add(
      DayForecast(
        code: weather['id'],
        date: day['dt_txt'],
        description: weather['description'],
        maxTemperature: main['temp_max'],
        minTemperature: main['temp_min']
      )
    );
  });
  return forecast;
}

class DayForecast {
  int code;
  String date;
  String description;
  dynamic maxTemperature;
  dynamic minTemperature;

  DayForecast(
      {this.code,
      this.date,
      this.description,
      this.maxTemperature,
      this.minTemperature
      });
}