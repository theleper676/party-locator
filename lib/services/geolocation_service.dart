import 'dart:async';

import 'package:geolocator/geolocator.dart';

class GeoLocationService {
  LocationPermission? isLocationPermitted;

  final StreamController<Position> _controller =
      StreamController<Position>.broadcast();
  Stream<Position> get geoLocatioStream => _controller.stream;

  GeoLocationService() {
    Geolocator.checkPermission().then((LocationPermission isPermitted) {
      if (isPermitted == LocationPermission.denied) {
        Geolocator.requestPermission();
      }
      Geolocator.getPositionStream(locationSettings: LocationSettings())
          .listen((Position currentPosition) {
        _controller.add(currentPosition);
      });
    });
  }
}
