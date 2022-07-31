import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locator/pages/location_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:locator/services/firestore_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  Set<LatLng>? location;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Center(
          child: TextButton(
        onPressed: () {
          var stream = FirestoreService('sessions').sessionStream;
          print(stream.map((event) => print(event.docs)));
        },
        child: Text('click here'),
      )),
    );
  }
}
