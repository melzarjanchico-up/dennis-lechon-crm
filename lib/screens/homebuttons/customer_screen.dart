// firestore test shiz
//import '../../services/test_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:dennis_lechon_crm/screens/login_screens/home_screen.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:dennis_lechon_crm/widgets/loading.dart';

List<Color> colors = [
  const Color(0xFFD3231E),
  const Color(0xFFF1A22C),
  const Color(0xFF2A87BB),
  const Color.fromARGB(255, 218, 40, 164),
  const Color.fromARGB(255, 24, 212, 65),
  const Color.fromARGB(255, 8, 8, 8),
  const Color.fromARGB(255, 187, 42, 102),
  const Color.fromARGB(255, 86, 42, 187),
  const Color.fromARGB(255, 51, 15, 180)
];

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ERROR: loading time still needs work because null exception will exist when data has not been fetched yet
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF1A22C),
          title: const Text("Customer List"),
          centerTitle: true,
        ),
        //listview.separate will be added for spacing
        body: Stack(children: <Widget>[
          Center(
            child: StreamBuilder(
              //to be separated
              stream: FirebaseFirestore.instance.collection('tags').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                return ListView(
                  children: snapshot.data!.docs.map((tags) {
                    return ElevatedButton.icon(
                      onPressed: () async {
                        //insert method
                      },
                      icon: const Icon(Icons.fireplace_rounded),
                      label: Text(
                        tags['name'],
                        style: GoogleFonts.oxygen(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: colors[3],
                        onPrimary: Colors.white,
                        elevation: 12,
                        minimumSize: const Size(400, 75),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ]));
  }
}
