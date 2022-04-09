// ignore_for_file: deprecated_member_use, file_names
//import 'package:dennis_lechon_crm/widgets/loading.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/search.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // to remove the debug banner
      debugShowCheckedModeBanner: false,
      title: "route",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFD3231E),
          title: const Text("Order List"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  // ask ko lng if order search ba ni? like ka search sa name kay ang order iyag mugawas?
                  delegate: SearchCustomer(),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            GestureDetector(
              onTap: () {
                // sa customer list ni siya na code po huehue
                //Navigator.push(
                //    context,
                //     MaterialPageRoute(
                //         builder: (context) => CustomerInfo(customer: customer)));
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
                                      const Text("Order No. 69",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text("Melzar Boang",
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
                            const Text('To be delivered on: 10/13/2022',
                                style: TextStyle(color: Colors.grey)),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.green),
                              child: const Text(
                                "Active",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ])
                    ],
                  ),
                ),
              ),
            ),
          ],
          /* This is the code for the back button

           RaisedButton(
            child: const Text("Back"),
            color: const Color(0xFFD3231E),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          */
        ),
      ),
    );
  }
}
