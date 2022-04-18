// this is a testing for the firestore capabilities hehe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/models/customer.dart';

class CustomerService {
  // collection reference
  final CollectionReference customerCollection =
      FirebaseFirestore.instance.collection('customers');
  late String currquery = '';
  String setQuery(String currquery) {
    this.currquery = currquery;
    return currquery;
  }

  // Add Customer Data
  Future addCustomer(
      String firstname,
      String middlename,
      String lastname,
      String zipcode,
      String barangay,
      String city,
      String celnum,
      String telnum,
      String note,
      String tagname,
      int index,
      String color) async {
    return await customerCollection.doc().set({
      'first_name': firstname,
      'middle_name': middlename,
      'last_name': lastname,
      'address': {'city': city, 'barangay': barangay, 'zipcode': zipcode},
      'cel_no': celnum,
      'tel_no': telnum,
      'note': note,
      'tag': {'tagname': tagname, 'index': index, 'color': color}
    });
  }

  List<Customer> _customerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      var preId = doc.id;
      var preFirstName = (doc.data() as Map)['first_name'] ?? '';
      var preMiddleName = (doc.data() as Map)['middle_name'] ?? '';
      var preLastName = (doc.data() as Map)['last_name'] ?? '';
      var preBirthDate = (doc.data() as Map)['date_added'] ?? '';
      var preDateAdded = (doc.data() as Map)['date_birth'] ?? '';
      var preCelNum = (doc.data() as Map)['cel_no'] ?? '';
      var preTelNum = (doc.data() as Map)['tel_no'] ?? '';
      var preAdrCity = (doc.data() as Map)['address']['city'] ?? '';
      var preAdrBarangay = (doc.data() as Map)['address']['barangay'] ?? '';
      var preAdrZipcode = (doc.data() as Map)['address']['zipcode'] ?? '';
      var preTagName = (doc.data() as Map)['tag']['tagname'] ?? '';
      var preTagColor = (doc.data() as Map)['tag']['color'] ?? '';
      var preTagIndex = (doc.data() as Map)['tag']['index'] ?? 4;
      var preNote = (doc.data() as Map)['note'] ?? '';

      return Customer(
        id: preId,
        firstName: preFirstName,
        middleName: preMiddleName,
        lastName: preLastName,
        birthDate: preBirthDate,
        dateAdded: preDateAdded,
        celNum: preCelNum,
        telNum: preTelNum,
        adrCity: preAdrCity,
        adrBarangay: preAdrBarangay,
        adrZipcode: preAdrZipcode,
        note: preNote,
        tagName: preTagName,
        tagIndex: preTagIndex,
        tagColor: preTagColor,
      );
    }).toList();
  }

  // Search snapshots to be converted to a list of customers

  Stream<List<Customer>>? get customers {
    return customerCollection
        .orderBy('tag.index')
        .orderBy('first_name')
        .snapshots()
        .map(_customerListFromSnapshot);
  }

  Stream<List<Customer>> makeStream(List<Customer> list) async* {
  yield list;
}
  /*
  Future<Customer> customerFromSnapshot(String id) async {

    var doc = await customerCollection.doc(id).get();

    var preId = doc.id;
    var preFirstName = (doc.data() as Map)['first_name'] ?? 'no firstname';
    var preMiddleName = (doc.data() as Map)['middle_name'] ?? 'no middlename';
    var preLastName = (doc.data() as Map)['last_name'] ?? 'no lastname';
    var preCelNum = (doc.data() as Map)['cel_no'] ?? 'no celnum';
    var preTelNum = (doc.data() as Map)['tel_no'] ?? 'no telnum';
    var preAdrCity = (doc.data() as Map)['address']['city'] ?? 'no city';
    var preAdrBarangay = (doc.data() as Map)['address']['barangay'] ?? 'no barangay';
    var preAdrZipcode = (doc.data() as Map)['address']['zipcode'] ?? 'no address';
    var preTagName = (doc.data() as Map)['tag']['tagname'] ?? 'no tagname';
    var preTagColor = (doc.data() as Map)['tag']['color'] ?? 'no tagcolor';
    var preTagIndex = (doc.data() as Map)['tag']['index'] ?? 4;
    var preNote = (doc.data() as Map)['note'] ?? 'no note';

    print(preFirstName);

    return Customer(
      id: preId,
      firstName: preFirstName,
      middleName: preMiddleName,
      lastName: preLastName,
      celNum: preCelNum,
      telNum: preTelNum,
      adrCity: preAdrCity,
      adrBarangay: preAdrBarangay,
      adrZipcode: preAdrZipcode,
      note: preNote,
      tagName: preTagName,
      tagIndex: preTagIndex,
      tagColor: preTagColor,
    );
  }
  */

}
