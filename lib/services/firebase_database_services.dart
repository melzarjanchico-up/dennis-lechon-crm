// this is a testing for the firestore capabilities hehe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/models/customer.dart';

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

  List<Customer> _customerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      //print(doc.data());
      return Customer(
        firstName: doc['first_name'] ?? '',
        middleName: doc['middle_name'] ?? '',
        lastName: doc['last_name'] ?? '',
        //celNum: doc['cel_no'] ?? '',
        //telNum: doc['tel_no'] ?? '',
        //adrCity: doc['address']['city'] ?? '',
        //adrBarangay: doc['address']['barangay'] ?? '',
        //adrZipcode: doc['address']['zipcode'] ?? '',
        //tagColor: doc['tag']['color'] ?? '',
        //tagIndex: doc['tag']['index'] ?? 4,
        //tagName: doc['tag']['tagname'] ?? '',
        //note: doc['note']
      );
    }).toList();
  }

  Stream<List<Customer>>? get customers {
    return customerCollection.snapshots().map(_customerListFromSnapshot);
  }

}
