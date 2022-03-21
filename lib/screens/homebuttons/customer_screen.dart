// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/screens/login_screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dennis_lechon_crm/widgets/loading.dart';

final List<String> entries = <String>[
  'Hot',
  'Warm',
  'Cold',
  'Kakamfenk',
  'BabyM',
  'Dead',
  'Fucker',
  'Fuckity',
  'FrFrNglIstg'
];
List<Color> colors = [
  Color(0xFFD3231E),
  Color(0xFFF1A22C),
  Color(0xFF2A87BB),
  Color.fromARGB(255, 218, 40, 164),
  Color.fromARGB(255, 24, 212, 65),
  Color.fromARGB(255, 8, 8, 8),
  Color.fromARGB(255, 187, 42, 102),
  Color.fromARGB(255, 86, 42, 187),
  Color.fromARGB(255, 51, 15, 180)
];

// firestore test shiz
//import '../../services/test_database.dart';

class CustomerScreen extends StatelessWidget {
  CustomerScreen({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> tags =
      FirebaseFirestore.instance.collection('tags').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1A22C),
        title: const Text("Customer List"),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return ElevatedButton.icon(
              onPressed: () async {},
              icon: const Icon(Icons.fireplace_rounded),
              label: Text(
                " ${entries[index]} ",
                style: GoogleFonts.oxygen(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: colors[index],
                onPrimary: Colors.white,
                elevation: 12,
                minimumSize: const Size(400, 75),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }
}
