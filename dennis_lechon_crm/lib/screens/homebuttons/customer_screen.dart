// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dennis_lechon_crm/widgets/loading.dart';

// firestore test shiz
import '../../services/test_database.dart';

class CustomerScreen extends StatelessWidget {
  CustomerScreen({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> tags =
      FirebaseFirestore.instance.collection('tags').snapshots();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "route",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF1A22C),
          title: const Text("Customer List"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () async {},
                icon: const Icon(Icons.fireplace_sharp),
                label: Text(
                  "Hot",
                  style: GoogleFonts.oxygen(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFD3231E),
                  onPrimary: Colors.white,
                  elevation: 12,
                  //shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(60.0)),
                  minimumSize: const Size(270, 90),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFF1A22C),
                  onPrimary: Colors.white,
                  elevation: 12,
                  //shape: RoundedRectangleBorder(
                  //    borderRadius: BorderRadius.circular(60.0)),
                  minimumSize: const Size(230, 90),
                ),
                icon: const Icon(Icons
                    .hot_tub), //walay warm na icon aay gikapoy nakog pangita hahaha
                label: Text(
                  "Warm",
                  style: GoogleFonts.oxygen(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF2A87BB),
                  onPrimary: Colors.white,
                  elevation: 12,
                  //shape: RoundedRectangleBorder(
                  //    borderRadius: BorderRadius.circular(60.0)),
                  minimumSize: const Size(230, 90),
                ),
                icon: const Icon(Icons.ac_unit),
                label: Text(
                  "Cold",
                  style: GoogleFonts.oxygen(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RaisedButton(
                child: const Text("Back"),
                color: const Color(0xFFF1A22C),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          //body: Center(
          //child:
        ),
      ),
    );
  }
}
