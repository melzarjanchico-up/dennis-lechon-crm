// this is a testing for the firestore capabilities hehe
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // collection reference
  final CollectionReference tagCollection =
      FirebaseFirestore.instance.collection('tags');
}
