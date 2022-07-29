import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:locator/services/location_service.dart';

class LocationPage extends StatefulWidget {
  LocationPage({Key? key}) : super(key: key);
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  GoogleMapController? _controller;
  final CameraPosition _initialcameraposition =
      const CameraPosition(target: LatLng(20.5937, 78.9629), zoom: 18);

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController cntrl) {
    _controller = cntrl;
  }

  void updateMarker(LocationData locationData) async {}

  void updateCamera(LocationData locationData) async {
    await _controller?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(locationData.latitude!, locationData.longitude!),
            zoom: 18)));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: LocationService().locationStream,
        builder: ((context, AsyncSnapshot<LocationData> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else {
            updateCamera(snapshot.data!);
            return Scaffold(
                body: Stack(
              children: [
                GoogleMap(
                    markers: {
                      Marker(
                          markerId: MarkerId('user'),
                          position: LatLng(snapshot.data!.latitude!,
                              snapshot.data!.longitude!)),
                    },
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: _initialcameraposition)
              ],
            ));
          }
        }));
  }
}
