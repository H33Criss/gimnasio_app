import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  Stream<QuerySnapshot> juegos() {
    return FirebaseFirestore.instance.collection('juegos').snapshots();
  }
  // Future<QuerySnapshot> juegos() {
  //   return FirebaseFirestore.instance.collection('juegos').snapshots();
  // }
}
