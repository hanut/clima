import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isLoading = true;
  Location? location;

  void _getLocation() async {
    try {
      var loc = Location();
      await loc.getCurrentLocation();
      setState(() {
        location = loc;
      });
      _getWeather();
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(
          e.toString(),
        ),
        duration: const Duration(seconds: 5),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {
      isLoading = false;
    });
  }

  void _getWeather() async {
    final weather = await loadWeatherFromOpenApi(location: location!);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(
          weather: weather,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(
          color: Colors.redAccent,
          strokeWidth: 5,
        ),
      )),
    );
  }
}
