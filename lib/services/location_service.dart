import 'dart:async';
import 'package:location/location.dart';

class LocationService {
  // Initlize location
  Location location = Location();
  // Create controller for stream
  final StreamController<LocationData> _controller =
      StreamController<LocationData>.broadcast();

  // Property of the location stream
  Stream<LocationData> get locationStream => _controller.stream;

  LocationService() {
    location.requestPermission().then((PermissionStatus permissionStatus) => {
          if (permissionStatus == PermissionStatus.denied)
            location.requestPermission()
          else if (permissionStatus == PermissionStatus.granted)
            {
              location.onLocationChanged.listen((LocationData currentLocation) {
                _controller.add(currentLocation);
              })
            }
        });
  }
}
