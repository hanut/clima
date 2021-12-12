import 'dart:convert';
import 'dart:io';

import 'package:clima/services/location.dart';
import 'package:clima/services/weather.dart';
import 'package:http/http.dart' as http;

const apiKey = "93fe339d8036fba905bf4d94f8dd7441";
const apiDomain = "api.openweathermap.org";
const baseUrl = "https://" + apiDomain + "/data/2.5/weather";

Future<bool> hasNetwork() async {
  try {
    final result = await InternetAddress.lookup(apiDomain);
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

Future<WeatherReport> loadWeatherFromOpenApi({
  required Location location,
}) async {
  if (!await hasNetwork()) {
    return Future.error(
        "Internet not available. Please reconnect and try again.");
  }

  var uri = Uri.parse(
    baseUrl +
        "?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey",
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

Future<WeatherReport> loadCityWeatherFromOpenApi({
  required String cityName,
}) async {
  if (!await hasNetwork()) {
    return Future.error(
        "Internet not available. Please reconnect and try again.");
  }

  var uri = Uri.parse(
    baseUrl + "?q=$cityName&units=metric&appid=$apiKey",
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
