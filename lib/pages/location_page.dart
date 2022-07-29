import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyMapPage extends StatefulWidget {
  MyMapPage({Key? key}) : super(key: key);

  @override
  State<MyMapPage> createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  late GoogleMapController _controller;
  Location location = Location();
  LatLng initalLatLang = const LatLng(24.150, -110.32);
  late Marker marker = _addMarker(const MarkerId('user'));

  void getCurrentLocation() async {
    location.onLocationChanged.listen((LocationData locationData) {
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          zoom: 18,
          target: LatLng(locationData.latitude!, locationData.longitude!))));
      setState(() {});
    });
  }

  void _onMapCreated(GoogleMapController googleMapController) {
    _controller = googleMapController;
  }

  _addMarker(MarkerId markerId) {
    return marker = Marker(
        markerId: markerId,
        position: initalLatLang,
        infoWindow: const InfoWindow(title: 'user'));
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
            markers: {marker},
            myLocationEnabled: true,
            onMapCreated: ((controller) {
              _onMapCreated(controller);
            }),
            initialCameraPosition:
                CameraPosition(target: marker.position, zoom: 18)),
      ],
    ));
  }
}
