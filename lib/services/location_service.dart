import 'dart:html';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService {
  Map<MarkerId, Marker>? _marker;
  final MarkerId markerId = MarkerId('user');

  Location _location = Location();
  LatLng? _position;

  Location? get location => _location;
  LatLng? get position => _position;

  getUserLocation() async {
    bool _isServiceEnabled;
    PermissionStatus _isPermitted;

    _isServiceEnabled = await _location.serviceEnabled();

    if (_isServiceEnabled) {
      await _location.requestService();
    }

    _isPermitted = await _location.requestPermission();

    if (_isPermitted == PermissionStatus.denied) {
      _isPermitted = await _location.requestPermission();
    }

    if (_isPermitted == PermissionStatus.granted) {
      return;
    }
  }
}
