// firestore test shiz
//import '../../services/test_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:dennis_lechon_crm/screens/login_screens/home_screen.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_info.dart';

class CustomerScreen extends StatelessWidget {
  CustomerScreen({Key? key}) : super(key: key);
  final CollectionReference _customerlist =
      FirebaseFirestore.instance.collection('customers');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1A22C),
        title: const Text("Customer List"),
        centerTitle: true,
      ),
      //listview.separate will be added for spacing
      body: StreamBuilder(
          stream: _customerlist.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text(
                  "Something went wrong! Please contact administrator.");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            }
            return ListView(
              padding: const EdgeInsets.all(20),
              children: snapshot.data!.docs.map((customers) {
                String lastName = customers['last_name'];
                String firstName = customers['first_name'];
                String tagName = customers['tagname'];
                //String address = customers['address'] as String;
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerInfo()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(children: [
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('${firstName} ${lastName}',
                                              // ignore: prefer_const_constructors
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text("address",
                                              style: TextStyle(
                                                  color: Colors.grey[500])),
                                        ]),
                                  )
                                ]),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.orange),
                                  child: Text(
                                    tagName,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ])
                        ],
                      ),
                    ));
              }).toList(),
            );
          }),
    );
  }
}
