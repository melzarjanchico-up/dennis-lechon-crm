
import 'package:dennis_lechon_crm/models/order.dart';
import 'package:dennis_lechon_crm/screens/order_screen/order_list/order_list.dart';
import 'package:dennis_lechon_crm/services/order_database_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../models/customer.dart';

class CustomerOrderList extends StatefulWidget {
  final Customer customer;

  const CustomerOrderList({ required this.customer, Key? key }) : super(key: key);

  @override
  State<CustomerOrderList> createState() => _CustomerOrderListState();
}

class _CustomerOrderListState extends State<CustomerOrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.customer.tagColor,
        title: Text('${widget.customer.firstName}\'s Order History',
            style: GoogleFonts.oxygen(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            )),
        centerTitle: true,
      ),
      body: StreamProvider<List<Order>>.value(
        value: OrderService().customerOrders(widget.customer.id), // as in wala koy mabuhat
        initialData: const [],
        child: const OrderListWidget(),
      ),
    );
  }
}