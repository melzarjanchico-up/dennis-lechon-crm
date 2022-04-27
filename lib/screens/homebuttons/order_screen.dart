import 'package:dennis_lechon_crm/services/order_database_services.dart';
import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:dennis_lechon_crm/models/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/search.dart';
import '../order_screen/order_list/order_list.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Order>>(
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
                    title: const Text("Order List"),
                    centerTitle: true,
                    actions: [
                      IconButton(
                        onPressed: () {
                          showSearch(
                            context: context,
                            delegate: SearchCustomer(),
                          );
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ],
                  ),
                  body: StreamProvider<List<Order>>.value(
                    value: OrderService().orders, // as in wala koy mabuhat
                    initialData: const [],
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 45.0),
                        child: const OrderListWidget()),
                  ),
                );
            }
          } else {
            (snapshot.error);
            return const Center(
              child: Text("Something went wrong. Please contact admin."),
            );
          }
        });
  }
}
