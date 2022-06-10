import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/widgets/style.dart';
import 'package:dennis_lechon_crm/screens/home_screen_new/nav_bar.dart';
import 'package:dennis_lechon_crm/screens/home_screen_new/components/body.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key, required this.firestore}) : super(key: key);
  final FirebaseFirestore firestore;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          title: const Text('Lech Go!',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: AppColors.redColor,
          // shape: const RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //     bottom: Radius.circular(40),
          //   ),
          // ),
          elevation: 0,
        ),
      ),
      drawer: NavBar(firestore: firestore),
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: Body(firestore: firestore),
    );
  }
}
