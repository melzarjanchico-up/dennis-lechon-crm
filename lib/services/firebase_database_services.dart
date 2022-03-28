// this is a testing for the firestore capabilities hehe
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:dennis_lechon_crm/models/customer.dart';

class CustomerService {
  // collection reference
  final CollectionReference customerCollection = FirebaseFirestore.instance.collection('customers');

  // Add Customer Data
  Future addCustomer(
      String firstname, String middlename, String lastname,
      String zipcode, String barangay, String city,
      String celnum, String telnum, String note,
      String tagname, int index, String color
    ) async {
    return await customerCollection.doc().set({
      'first_name': firstname,
      'middle_name': middlename,
      'last_name': lastname,
      'address': {'city': city, 'barangay': barangay, 'zipcode': zipcode},
      'cel_no': celnum,
      'tel_no': telnum,
      'note': note,
      'tag': {'tagname': tagname, 'index': 2, 'color': "Color(0xFFF1A22C)"}
    });
  }


}
