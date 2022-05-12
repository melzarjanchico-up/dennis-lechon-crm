
import 'package:dennis_lechon_crm/models/order.dart';
import 'package:dennis_lechon_crm/screens/order_screen/order_list/order_list.dart';
import 'package:dennis_lechon_crm/services/order_database_services.dart';
import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    return StreamBuilder<List<Order>>(
      stream: OrderService().customerOrders(widget.customer.id),
      builder: (context, snapshot) {
        if (!snapshot.hasError) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(child: Text("Offline. Try again later."));
            case ConnectionState.waiting:
              return Container(
                color: widget.customer.tagColor,
                child: const Center(
                  child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 65.0,
                  ),
                ),
              );
            default:
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: widget.customer.tagColor,
                  title: Text('${widget.customer.firstName}\'s Order History',
                    style: GoogleFonts.oxygen(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    )
                  ),
                  centerTitle: true,
                ),
                body: (snapshot.data!.isNotEmpty) ? StreamProvider<List<Order>>.value(
                  value: OrderService().customerOrders(widget.customer.id), // as in wala koy mabuhat
                  initialData: const [],
                  child: const OrderListWidget(),
                ) : const Center(
                  child: Text("Customer's order history is empty."),
                )
              );
          }
        } else {
          return Center(
            child: Text(
              "Something went wrong. Please contact admin. ${snapshot.error}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }
      }
    );
  }
}

/*
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
      body: StreamBuilder<List<Order>>(
        stream: OrderService().customerOrders(widget.customer.id),
        builder: (context, snapshot) {
          if (!snapshot.hasError) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(child: Text("Offline. Try again later."));
              case ConnectionState.waiting:
                return const Loading();
              default:
                return (snapshot.data!.isNotEmpty) ? StreamProvider<List<Order>>.value(
                  value: OrderService().customerOrders(widget.customer.id), // as in wala koy mabuhat
                  initialData: const [],
                  child: const OrderListWidget(),
                ) : const Center(
                  child: Text("Customer's order history is empty."),
                );
            }
          } else {
            return Center(
              child: Text(
                "Something went wrong. Please contact admin. ${snapshot.error}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
        }
      ),
    );
  }
}
*/