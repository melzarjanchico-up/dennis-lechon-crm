
import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_info/customer_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class CustomerListWidget extends StatefulWidget {
  const CustomerListWidget({ Key? key }) : super(key: key);

  @override
  State<CustomerListWidget> createState() => _CustomerListWidgetState();
}

class _CustomerListWidgetState extends State<CustomerListWidget> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference _customerlist =
      FirebaseFirestore.instance.collection('customers');

    return StreamBuilder(
          stream: _customerlist.orderBy('tag.index').orderBy('first_name').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
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
                String tagName = customers['tag']['tagname'];
                String address = '${customers['address']['barangay']}, ${customers['address']['city']} ${customers['address']['zipcode']}';
                String colorString = (customers['tag']['color']).split('(0x')[1].split(')')[0];
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(children: [
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
                      ),
                    ));
              }).toList(),
            );
          });
  }
}