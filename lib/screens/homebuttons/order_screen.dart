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
                    title: Text(
                      "Order List",
                      style: GoogleFonts.oxygen(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
                  floatingActionButton: FloatingActionButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Add Order"),
                              content: const Text(
                                  "Does the customer already exist?"),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      //if mu yes siya kay dapat ig fill out niya sa order kay naa natong scroll2 na
                                      //makapili na siya sa customer niya automatic na fill out sa info
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AddOrder()));
                                    },
                                    child: const Text("Yes")),
                                TextButton(
                                    onPressed: () {
                                      //diri to dapat ang mag add pa siya sa customer bag.o siya ka add ug order
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("No"))
                              ],
                            );
                          });
                    },
                    child: const Icon(
                      Icons.add,
                      size: 26.0,
                    ),
                    backgroundColor: const Color(0xFFF1A22C),
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
