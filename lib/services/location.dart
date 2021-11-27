import 'package:geolocator/geolocator.dart';

class Location {
  double _latitude = 0;
  double _longitude = 0;

  get latitude {
    return _latitude;
  }

  get longitude {
    return _longitude;
  }

  Future<void> getCurrentLocation() async {
    try {
      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      _latitude = pos.latitude;
      _longitude = pos.longitude;
    } catch (e) {
      rethrow;
    }
  }
}
