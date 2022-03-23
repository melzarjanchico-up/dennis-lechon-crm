// firestore test shiz
//import '../../services/test_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:dennis_lechon_crm/screens/login_screens/home_screen.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dennis_lechon_crm/widgets/loading.dart';


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
      body: Center(
        child: StreamBuilder(
          //to be separated
          stream: FirebaseFirestore.instance.collection('tags').snapshots(),
          builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

            if (snapshot.hasError) {
              return const Text("Something went wrong! Please contact administrator.");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            }

            return ListView(
              children: snapshot.data!.docs.map((tags) {

                // name
                String tagName = tags['name'];

                // color
                String tagColorString = tags['color'].split('(0x')[1].split(')')[0];
                int tagColor = int.parse(tagColorString, radix: 16);

                return ElevatedButton.icon(
                  onPressed: () async {
                    //insert method
                  },
                  icon: const Icon(Icons.fireplace_rounded),
                  label: Text(
                    tagName,
                    style: GoogleFonts.oxygen(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(tagColor),
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
    );
  }
}
