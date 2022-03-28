import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerListWidget extends StatefulWidget {
  const CustomerListWidget({ Key? key }) : super(key: key);

  @override
  State<CustomerListWidget> createState() => _CustomerListWidgetState();
}

class _CustomerListWidgetState extends State<CustomerListWidget> {
  @override
  Widget build(BuildContext context) {

    final customers = Provider.of<List<Customer>>(context);
    for (var customer in customers) {
      debugPrint(customer.firstName);
      debugPrint(customer.middleName);
      debugPrint(customer.lastName);
      debugPrint("-------");
    }

    return Container(
      
    );

  }
}