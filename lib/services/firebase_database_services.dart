// this is a testing for the firestore capabilities hehe
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:dennis_lechon_crm/models/customer.dart';

class CustomerService {
  // collection reference
  final CollectionReference customerCollection = FirebaseFirestore.instance.collection('customers');
}
