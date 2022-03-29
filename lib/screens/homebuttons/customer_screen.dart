import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/services/firebase_database_services.dart';
import 'package:provider/provider.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/customer_list.dart';


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
                  Icons.add_circle_outline,
                  size: 26.0,
                ),
              )
            )
          ],

        ),

        body: StreamBuilder<List<Customer>> (
          stream: CustomerService().customers,
          builder: (context, snapshot) {
            if (!snapshot.hasError) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Text("Offline. Try again later.");
                case ConnectionState.waiting:
                  return const Loading();
                case ConnectionState.done:
                case ConnectionState.active:
                  return const CustomerListWidget();
                default:
                  return const Text("Something went wrong. Please contact admin");
              }
            } else {
              return const Text("Something went wrong. Please contact admin.");
            }
          },
        )

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