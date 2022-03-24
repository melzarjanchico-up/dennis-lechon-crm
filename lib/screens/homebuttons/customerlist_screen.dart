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

            // I will have to seperate this list view soon. just you wait.
            return ListView(
              padding: const EdgeInsets.all(20),
              children: snapshot.data!.docs.map((customers) {

                String lastName = customers['last_name'];
                String firstName = customers['first_name'];
                String tagName = customers['tagname'];
                String address = '${customers['address']['barangay']}, ${customers['address']['city']} ${customers['address']['zipcode']}';
                String colorString = customers['color'].split('(0x')[1].split(')')[0];
                int colorValue = int.parse(colorString, radix: 16);

                //String address = customers['address'] as String;
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CustomerInfo()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(children: [
                                  const SizedBox(width: 10),
                                  Flexible(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('$firstName $lastName',
                                              // ignore: prefer_const_constructors
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(address,
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
                                      vertical: 4, horizontal: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color(colorValue)),
                                  child: Text(
                                    tagName,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const Text('Incoming Order')
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
