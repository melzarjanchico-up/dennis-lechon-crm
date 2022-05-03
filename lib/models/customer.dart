import 'package:flutter/material.dart';

class Customer {
  final String id;
  final String firstName;
  final String middleName;
  final String lastName;
  final DateTime? dateBirth;
  final DateTime? dateAdded;
  final String celNum;
  final String telNum;
  final String adrStreet;
  final String adrBarangay;
  final String adrCity;
  final String adrZipcode;
  final String adrProvince;
  final String note;
  final String tagName;
  final int tagIndex;
  final Color tagColor;

  const Customer({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dateBirth,
    required this.dateAdded,
    required this.celNum,
    required this.telNum,
    required this.adrStreet,
    required this.adrBarangay,
    required this.adrCity,
    required this.adrZipcode,
    required this.adrProvince,
    required this.note,
    required this.tagName,
    required this.tagIndex,
    required this.tagColor,
  });
}
