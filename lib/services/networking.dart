import 'dart:convert';

import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;

const apiKey = "";

class WeatherReport {
  final String city;
  final double temperature;
  final int condition;

  WeatherReport({
    required this.city,
    required this.condition,
    required this.temperature,
  });
}

Future<WeatherReport> loadWeatherFromOpenApi({
  required Location location,
}) async {
  var uri = Uri.parse(
    "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=${apiKey}",
  );

  http.Response response = await http.get(uri);
  if (response.statusCode != 200) {
    return Future.error(response.reasonPhrase ?? "Unknown Error");
  }

  final decodedData = jsonDecode(response.body);
  return WeatherReport(
    city: decodedData['name'],
    condition: decodedData["weather"][0]["id"],
    temperature: decodedData["main"]["temp"],
  );
}
