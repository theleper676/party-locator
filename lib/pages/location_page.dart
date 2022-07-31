import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locator/services/geolocation_service.dart';
import 'package:locator/services/database_service.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  GoogleMapController? _controller;
  final CameraPosition _initialcameraposition =
      const CameraPosition(target: LatLng(37.785834, -122.406417), zoom: 18);

  // Stream of the Current Logged Markers.
  Stream<DatabaseEvent> dbStream = FirestoreService().usersStreams;

  Set<Marker> markerList = {};
  @override
  void initState() {
    updateMarker();
    super.initState();
  }

  void _onMapCreated(GoogleMapController cntrl) {
    _controller = cntrl;
  }

  void updateMarker() async {
    await dbStream.forEach((DatabaseEvent element) {
      element.snapshot.children.map((DataSnapshot e) {
        markerList = {
          const Marker(
              markerId: MarkerId(
                'ds',
              ),
              position: (const LatLng(37.785834, -122.406417)))
        };
      });
      print(markerList);
    });
  }

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
                appBar: AppBar(
                  elevation: 0,
                  title: const Text('Locate your fiends'),
                ),
                body: Stack(
                  children: <Widget>[
                    GoogleMap(
                        markers: {
                          Marker(
                              markerId: MarkerId('sdd'),
                              position: LatLng(37.785834, -122.406417))
                        },
                        myLocationEnabled: true,
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: _initialcameraposition),
                  ],
                ));
          }
        }));
  }
}
