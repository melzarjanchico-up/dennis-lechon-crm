// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/add_customer_new.dart';
import 'package:dennis_lechon_crm/screens/order_screen/order_list/add_order.dart';
import 'package:dennis_lechon_crm/services/order_database_services.dart';
import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:dennis_lechon_crm/models/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/search.dart';
import '../order_screen/order_list/order_list.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({Key? key, required this.firestore}) : super(key: key);
  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: StreamBuilder<List<Order>>(
          key: const Key("Stream Order"),
          stream: OrderService().orders,
          builder: (context, snapshot) {
            if (!snapshot.hasError) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center(child: Text("Offline. Try again later."));
                case ConnectionState.waiting:
                  return const Loading();
                default:
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: const Color(0xFFD3231E),
                      title: Text(
                        "Order List",
                        style: GoogleFonts.oxygen(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      centerTitle: true,
                      // actions: [
                      //   IconButton(
                      //     onPressed: () {
                      //       showSearch(
                      //           context: context,
                      //           delegate: null //SearchCustomer(),
                      //           );
                      //     },
                      //     icon: const Icon(Icons.search),
                      //   ),
                      // ],
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () async {   
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddOrder(firestore: firestore,)));
                      },
                      child: const Icon(
                        Icons.add,
                        size: 26.0,
                      ),
                      backgroundColor: const Color(0xFFF1A22C),
                    ),
                    body: StreamProvider<List<Order>>.value(
                      key: const Key("OrderProvider Part"),
                      value: OrderService().orders, // as in wala koy mabuhat
                      initialData: const [],
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 45.0),
                          child: OrderListWidget(firestore: firestore,)),
                    ),
                  );
              }
            } else {
              (snapshot.error);
              return Center(
                child: Text("Something went wrong. Please contact admin. ${snapshot.error}"),
              );
            }
          }),
    );
  }
}
