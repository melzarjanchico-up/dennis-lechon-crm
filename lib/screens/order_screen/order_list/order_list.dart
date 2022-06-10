import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/models/order.dart';
import 'package:dennis_lechon_crm/screens/order_screen/order_info/order_info_new.dart';
import 'package:dennis_lechon_crm/widgets/style.dart';
//import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;

class OrderListWidget extends StatefulWidget {
  const OrderListWidget({Key? key, required this.firestore}) : super(key: key);
  final FirebaseFirestore firestore;

  @override
  State<OrderListWidget> createState() => _OrderListWidgetState();
}

class _OrderListWidgetState extends State<OrderListWidget> {
  final format = intl.DateFormat("dd MMM yyyy, h:mm a");

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context);

    return (orders.isEmpty)
        ? const Directionality(
            key: Key("Spin"),
            textDirection: TextDirection.ltr,
            child: Center(
              child: SpinKitFadingCircle(
                color: Colors.black45,
                size: 50.0,
              ),
            ))
        : Directionality(
            key: const Key("Order List from OrderListWidget"),
            textDirection: TextDirection.ltr,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: orders.map((order) {
                String orderHash = order.id.substring(0, 5);
                bool deliveryType = order.isRush;
                String firstName = order.firstName;
                String lastName = order.lastName;

                return GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return OrderInfo(
                              order: order,
                              firestore: widget.firestore,
                            );
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Order #$orderHash',
                                              style: GoogleFonts.mulish(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "$firstName $lastName",
                                              style: GoogleFonts.mulish(
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: (order.dateDelivery
                                              .isBefore(DateTime.now()))
                                          ? AppColors.redColor
                                          : (order.dateDelivery.isBefore(
                                                  DateTime.now().add(
                                                      const Duration(days: 7))))
                                              ? AppColors.yellowColor
                                              : AppColors.blueColor,
                                    ),
                                    child: Text(
                                      format.format(order.dateDelivery),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.mulish(
                                          color: Colors.white),
                                    ),
                                  )),
                                  const SizedBox(
                                    height: 20,
                                    width: 70,
                                  ),
                                  deliveryType
                                      ? const Icon(
                                          Icons.alarm,
                                          color: Colors.black54,
                                          size: 25.0,
                                        )
                                      //Text("RUSH",style: GoogleFonts.mulish())
                                      : const Text("       "),
                                ])
                          ],
                        ),
                      ),
                    ));
              }).toList(),
            ));
  }
}
