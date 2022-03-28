// ignore_for_file: deprecated_member_use, file_names
//import 'package:dennis_lechon_crm/widgets/loading.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "route",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFD3231E),
          title: const Text("Order List"),
        ),
        body: Center(
          child: RaisedButton(
            child: const Text("Back"),
            color: const Color(0xFFD3231E),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
