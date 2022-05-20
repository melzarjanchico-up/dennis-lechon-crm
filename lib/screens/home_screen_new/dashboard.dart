import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/screens/home_screen_new/components/body.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key, required this.firestore}) : super(key: key);
  final FirebaseFirestore firestore;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: Body(firestore: firestore),
    );
  }
}
