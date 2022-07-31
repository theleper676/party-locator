import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:locator/services/geolocation_service.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  GoogleMapController? _controller;
  final CameraPosition _initialcameraposition =
      const CameraPosition(target: LatLng(37.785834, -122.406417), zoom: 18);
  MarkerId user = const MarkerId('user');

  late Set<Marker> markerList;

  @override
  void initState() {
    markerList = {
      Marker(
        markerId: user,
        position: _initialcameraposition.target,
      )
    };
    super.initState();
  }

  void _onMapCreated(GoogleMapController cntrl) {
    _controller = cntrl;
  }

  void updateMarker(LocationData locationData) async {}

  void updateCamera(Position locationData) async {
    await _controller?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(locationData.latitude, locationData.longitude),
            zoom: 18)));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: GeoLocationService().geoLocatioStream,
        builder: ((context, AsyncSnapshot<Position> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else {
            updateCamera(snapshot.data!);
            return Scaffold(
                body: Stack(
              children: [
                GoogleMap(
                    markers: markerList,
                    myLocationEnabled: true,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: _initialcameraposition)
              ],
            ));
          }
        }));
  }
}
