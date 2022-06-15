import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/screens/order_screen/order_list/order_list.dart';
import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:provider/provider.dart';
import '../screens/customer_screen/customer_list/customer_list.dart';
import '../services/customer_database_services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dennis_lechon_crm/models/order.dart';
import 'package:dennis_lechon_crm/services/order_database_services.dart';

class SearchCustomer extends SearchDelegate {
  final FirebaseFirestore firestore;
  Key key = const Key("Customer Search here");
  SearchCustomer({required this.firestore, Key? key});
  @override
  List<Widget> buildActions(BuildContext context) {
    //para ra ni tig clear  sa search bar if pisliton ang 'x'
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  //tig balik sa customer list na page (back)
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  //if naa siyay makita na match kay e sud niya diri na string
  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<List<Customer>>(
        stream: CustomerService(firestore: firestore)
            .customers
            ?.asBroadcastStream(
                onCancel: (sub) => sub.cancel()), // to avoid data leakage
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Loading();
          } else {
            if (snapshot.data!
                .where((element) => '${element.firstName} ${element.lastName}'
                    .toLowerCase()
                    .contains(query.toLowerCase()))
                .isEmpty) {
              return Center(
                child: Text("I'm sorry. No customer exists.",
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: const Color(0xFF1F2426))),
              );
            } else {
              var searchResult = snapshot.data!
                  .where((element) => '${element.firstName} ${element.lastName}'
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .map((e) => e) //to map the Customer object
                  .toList();
              return StreamProvider<List<Customer>>.value(
                value: CustomerService(firestore: firestore)
                    .makeStream(searchResult),
                initialData: const [],
                child: Container(
                    margin: const EdgeInsets.only(bottom: 45.0),
                    child: CustomerListWidget(firestore: firestore)),
              );
            }
          }
        });
  }

  @override
  //same ra ni sa babaw, pero sa suggestion ni siya para char
  //maybe naa moy maadd diri po?
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<List<Customer>>(
        stream: CustomerService(firestore: firestore)
            .customers
            ?.asBroadcastStream(
                onCancel: (sub) => sub.cancel()), // to avoid data leakage
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Loading();
          } else {
            if (snapshot.data!
                .where((element) => '${element.firstName} ${element.lastName}'
                    .toLowerCase()
                    .contains(query.toLowerCase()))
                .isEmpty) {
              return Center(
                child: Text("I'm sorry. No customer exists.",
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: const Color(0xFF1F2426))),
              );
            } else {
              var searchResult = snapshot.data!
                  .where((element) => '${element.firstName} ${element.lastName}'
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .map((e) => e) //to map the Customer object
                  .toList();
              return StreamProvider<List<Customer>>.value(
                value: CustomerService(firestore: firestore)
                    .makeStream(searchResult),
                initialData: const [],
                child: Container(
                    margin: const EdgeInsets.only(bottom: 45.0),
                    child: CustomerListWidget(firestore: firestore)),
              );
            }
          }
        });
  }
}

class SearchOrder extends SearchDelegate {
  final FirebaseFirestore firestore;
  Key key = const Key("Customer Search here");
  SearchOrder({required this.firestore, Key? key});

  @override
  List<Widget> buildActions(BuildContext context) {
    //para ra ni tig clear  sa search bar if pisliton ang 'x'
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  //tig balik sa customer list na page (back)
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  //if naa siyay makita na match kay e sud niya diri na string
  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<List<Order>>(
        stream: OrderService(firestore: firestore).orders?.asBroadcastStream(
            onCancel: (sub) => sub.cancel()), // to avoid data leakage
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Loading();
          } else {
            if (snapshot.data!
                .where((element) => '${element.firstName} ${element.lastName}'
                    .toLowerCase()
                    .contains(query.toLowerCase()))
                .isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                      "I'm sorry. This customer has no orders or does not exist.",
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: const Color(0xFF1F2426))),
                ),
              );
            } else {
              var searchResult = snapshot.data!
                  .where((element) => '${element.firstName} ${element.lastName}'
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .map((e) => e) //to map the Customer object
                  .toList();
              return StreamProvider<List<Order>>.value(
                value:
                    OrderService(firestore: firestore).makeStream(searchResult),
                initialData: const [],
                child: Container(
                    margin: const EdgeInsets.only(bottom: 45.0),
                    child: OrderListWidget(firestore: firestore)),
              );
            }
          }
        });
  }

  @override
  //same ra ni sa babaw, pero sa suggestion ni siya para char
  //maybe naa moy maadd diri po?
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<List<Order>>(
        stream: OrderService(firestore: firestore).orders?.asBroadcastStream(
            onCancel: (sub) => sub.cancel()), // to avoid data leakage
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Loading();
          } else {
            if (snapshot.data!
                .where((element) => '${element.firstName} ${element.lastName}'
                    .toLowerCase()
                    .contains(query.toLowerCase()))
                .isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                      "I'm sorry. This customer has no orders or does not exist.",
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: const Color(0xFF1F2426))),
                ),
              );
            } else {
              var searchResult = snapshot.data!
                  .where((element) => '${element.firstName} ${element.lastName}'
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .map((e) => e) //to map the Customer object
                  .toList();
              return StreamProvider<List<Order>>.value(
                value:
                    OrderService(firestore: firestore).makeStream(searchResult),
                initialData: const [],
                child: Container(
                    margin: const EdgeInsets.only(bottom: 45.0),
                    child: OrderListWidget(firestore: firestore)),
              );
            }
          }
        });
  }
}
