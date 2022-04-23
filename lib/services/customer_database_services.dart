// this is a testing for the firestore capabilities hehe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:flutter/material.dart';

class CustomerService {
  // collection reference
  final CollectionReference customerCollection =
      FirebaseFirestore.instance.collection('customers');

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
      'tag': {'tagname': tagname, 'index': index, 'color': color},
    });
  }

  List<Customer> _customerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      String preId = doc.id;
      String preFirstName = (doc.data() as Map)['first_name'] ?? '';
      String preMiddleName = (doc.data() as Map)['middle_name'] ?? '';
      String preLastName = (doc.data() as Map)['last_name'] ?? '';
      Timestamp preDateBirth = (doc.data() as Map)['birth_date'] ?? Timestamp.fromMicrosecondsSinceEpoch(0);
      Timestamp preDateAdded = (doc.data() as Map)['added_date'] ?? Timestamp.fromMicrosecondsSinceEpoch(0);
      String preCelNum = (doc.data() as Map)['cel_no'] ?? '';
      String preTelNum = (doc.data() as Map)['tel_no'] ?? '';
      String preAdrCity = (doc.data() as Map)['address']['city'] ?? '';
      String preAdrBarangay = (doc.data() as Map)['address']['barangay'] ?? '';
      String preAdrZipcode = (doc.data() as Map)['address']['zipcode'] ?? '';
      String preTagName = (doc.data() as Map)['tag']['tagname'] ?? 'Untagged';
      String preTagColor = (doc.data() as Map)['tag']['color'] ?? const Color.fromARGB(255, 29, 29, 29).toString();
      int preTagIndex = (doc.data() as Map)['tag']['index'] ?? 99;
      String preNote = (doc.data() as Map)['note'] ?? '';

      return Customer(
        id: preId,
        firstName: preFirstName,
        middleName: preMiddleName,
        lastName: preLastName,
        dateBirth: preDateBirth.toDate(),
        dateAdded: preDateAdded.toDate(),
        celNum: preCelNum,
        telNum: preTelNum,
        adrCity: preAdrCity,
        adrBarangay: preAdrBarangay,
        adrZipcode: preAdrZipcode,
        note: preNote,
        tagName: preTagName,
        tagIndex: preTagIndex,
        tagColor: Color(int.parse((preTagColor).split('(0x')[1].split(')')[0], radix: 16)),
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
