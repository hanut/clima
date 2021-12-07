import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

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

class WeatherModel {
  static Future<WeatherReport> getWeatherData() async {
    try {
      var location = Location();
      await location.getCurrentLocation();
      return await loadWeatherFromOpenApi(location: location);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  static String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
