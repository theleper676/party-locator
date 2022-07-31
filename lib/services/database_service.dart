import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirestoreService {
  FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference ref;
  final StreamController<DatabaseEvent> _rtdbStreamController =
      StreamController<DatabaseEvent>.broadcast();

  Stream<DatabaseEvent> get usersStreams => _rtdbStreamController.stream;

  FirestoreService() {
    database.useDatabaseEmulator('localhost', 9000);
    ref = database.ref('-N8JS5Fx6zppkvTnPQVg');

    ref.onValue
        .listen((DatabaseEvent event) => _rtdbStreamController.add(event));
  }

  Future<void> getSessions() async {
    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
    });
  }

  Future<void> writeUser() async {
    try {
      await ref.set({'test': 'trest'});
    } on FirebaseException catch (error) {
      print(error);
    }
  }
}
