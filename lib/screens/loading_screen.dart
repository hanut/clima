import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isLoading = true;

  void _getLocation() async {
    try {
      final weather = await WeatherModel.getWeatherData();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(
            weather: weather,
          ),
        ),
      );
    } catch (e) {
      showSnack(e.toString());
    }
    setState(() {
      isLoading = false;
    });
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

  showSnack(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
      ),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
