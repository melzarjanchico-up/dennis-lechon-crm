// this is a testing for the firestore capabilities hehe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:dennis_lechon_crm/models/tags.dart';
import 'package:flutter/material.dart';

class CustomerService {
  // collection reference
  final CollectionReference customerCollection =
      FirebaseFirestore.instance.collection('customers');

  // Add Customer Data
  Future addCustomer(
      String firstname, String middlename, String lastname,
      String street, String barangay, 
      String city, String zipcode, String province,
      String celnum, String telnum,
      DateTime? birthdate, String? note, Tag? tag
    ) async {
      return await customerCollection.add({
        'first_name': firstname,
        'middle_name': middlename,
        'last_name': lastname,
        'cel_no': celnum,
        'tel_no': telnum,
        'address': {'street': street, 
                    'barangay': barangay, 
                    'city': city, 
                    'zipcode': zipcode, 
                    'province': province
                    },
        'birth_date': birthdate.toString(),
        'added_date': Timestamp.now(),
        'note': note,
        'tag': {'tagname': tag!.name, 'index': tag.index.toInt(), 'color': tag.tagColor.toString()},
      }
    );
  }

  Future editCustomer(
      String docId, String firstname, String middlename, String lastname,
      String street, String barangay, 
      String city, String zipcode, String province,
      String celnum, String telnum,
      DateTime? birthdate, DateTime addeddate, String? note, Tag? tag
    ) async {
      return await customerCollection.doc(docId).set({
        'first_name': firstname,
        'middle_name': middlename,
        'last_name': lastname,
        'cel_no': celnum,
        'tel_no': telnum,
        'address': {'street': street, 
                    'barangay': barangay, 
                    'city': city, 
                    'zipcode': zipcode, 
                    'province': province
                    },
        'birth_date': birthdate.toString(),
        'added_date': Timestamp.fromDate(addeddate),
        'note': note,
        'tag': {'tagname': tag!.name, 'index': tag.index.toInt(), 'color': tag.tagColor.toString()},
      });
  }

  List<Customer> _customerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      String preId = doc.id;
      String? preFirstName = (doc.data() as Map)['first_name'];
      String? preMiddleName = (doc.data() as Map)['middle_name'];
      String? preLastName = (doc.data() as Map)['last_name'];
      String? preDateBirth = (doc.data() as Map)['birth_date'];
      Timestamp? preDateAdded = (doc.data() as Map)['added_date'];
      String? preCelNum = (doc.data() as Map)['cel_no'];
      String? preTelNum = (doc.data() as Map)['tel_no'];
      String? preAdrStreet = (doc.data() as Map)['address']['street'];
      String? preAdrBarangay = (doc.data() as Map)['address']['barangay'];
      String? preAdrCity = (doc.data() as Map)['address']['city'];
      String? preAdrZipcode = (doc.data() as Map)['address']['zipcode'];
      String? preAdrProvince = (doc.data() as Map)['address']['province'];
      String preTagName = (doc.data() as Map)['tag']['tagname'];
      String preTagColor = (doc.data() as Map)['tag']['color'];
      int preTagIndex = (doc.data() as Map)['tag']['index'];
      String? preNote = (doc.data() as Map)['note'];

      return Customer(
        id: preId,
        firstName: preFirstName ?? '',
        middleName: preMiddleName ?? '',
        lastName: preLastName ?? '',
        dateBirth: (preDateBirth != null) ? DateTime.tryParse(preDateBirth) : null,
        dateAdded: (preDateAdded != null) ? preDateAdded.toDate() : null,
        celNum: preCelNum ?? '',
        telNum: preTelNum ?? '',
        adrStreet: preAdrStreet ?? '',
        adrBarangay: preAdrBarangay ?? '',
        adrCity: preAdrCity ?? '',
        adrZipcode: preAdrZipcode ?? '',
        adrProvince: preAdrProvince ?? '',
        note: preNote ?? '',
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

  // To convert List<Customer> to Stream<List<Customer>>
  Stream<List<Customer>> makeStream(List<Customer> list) async* {
    yield list;
  }
}
