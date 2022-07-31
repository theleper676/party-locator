import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late Stream<QuerySnapshot<Map<String, dynamic>>> sessionStream;

  FirestoreService(String collectionName) {
    sessionStream = db.collection(collectionName).get().asStream();
  }
}
