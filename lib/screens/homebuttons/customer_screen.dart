//import '../../services/test_database.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/customerlist_widget.dart';
//import 'package:dennis_lechon_crm/screens/login_screens/home_screen.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:dennis_lechon_crm/widgets/loading.dart';
//import 'package:dennis_lechon_crm/screens/customer_screen/customer_info/customer_info.dart';
import 'package:dennis_lechon_crm/services/firebase_database_services.dart';
import 'package:provider/provider.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
//import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/customer_list.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Customer>>.value(
      value: CustomerService().customers, 
      initialData: const [],

      child: Scaffold(

        appBar: AppBar(
          backgroundColor: const Color(0xFFF1A22C),
          title: const Text("Customer List"),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  await CustomerService().addCustomer("Ariana", "Paquibot", "Grande", "6015", "Basak", "Lapu-Lapu", "123", "456", "Heehee", "Warm", 2, "Color(0xFFF1A22C)");
                },
                child: const Icon(
                  Icons.account_circle,
                  size: 26.0,
                ),
              )
            )
          ],
        ),

        //body: const Text("hellaur")
        body: const CustomerListWidget(),

      ),
    );
  }
}

/*
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF1A22C),
          title: const Text("Customer List"),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  await CustomerService().addCustomer("Ariana", "Paquibot", "Grande", "6015", "Basak", "Lapu-Lapu", "123", "456", "Heehee", "Warm", 2, "Color(0xFFF1A22C)");
                },
                child: const Icon(
                  Icons.account_circle,
                  size: 26.0,
                ),
              )
            )
          ],
        ),
        //body: const CustomerListWidget(),
      ),
*/