import 'package:dennis_lechon_crm/models/order.dart';
import 'package:dennis_lechon_crm/screens/order_screen/order_info/order_info.dart';
import 'package:dennis_lechon_crm/services/customer_database_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/customer.dart';
import '../../../widgets/loading.dart';

class OrderListWidget extends StatefulWidget {
  const OrderListWidget({Key? key}) : super(key: key);

  @override
  State<OrderListWidget> createState() => _OrderListWidgetState();
}

class _OrderListWidgetState extends State<OrderListWidget> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: orders.map((order) {
        String deliveryDate = order.deliveryDate;
        String orderHash = order.id.substring(0, 5);
        bool deliveryType = order.deliveryType;
        return GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return OrderInfo(order: order);
                  });
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Order #$orderHash',
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    getCustomerDetails(
                                        context, order.customerid),
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
                                color: Colors.redAccent),
                            child: Text(
                              deliveryDate,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          deliveryType
                              ? const Text("\u{26A1} RUSH")
                              : const Text(""),
                        ])
                  ],
                ),
              ),
            ));
      }).toList(),
    );
  }

  Widget getCustomerDetails(BuildContext context, String customerID) {
    return StreamBuilder<List<Customer>>(
        stream: CustomerService().customers?.asBroadcastStream(
            onCancel: (sub) => sub.cancel()), // to avoid data leakage
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Loading();
          } else {
            var searchResult = snapshot.data!
                .where((element) => element.id.contains(customerID))
                .map((e) => e) //to map the Customer object
                .toList();
            return Text("$searchResult['firstName']",
                style: TextStyle(color: Colors.grey[500]));
          }
        });
  }
  /*
  Widget getCustomerDetails(String customerId) {
    final customers = CustomerService().customers
    var customerDetails =
        customers.where((element) => element.id.contains(customerId)).toList();
    return Text("chulaloooo", style: TextStyle(color: Colors.grey[500]));
  }*/
}
