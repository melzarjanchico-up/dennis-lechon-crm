import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/models/order.dart';
import 'package:dennis_lechon_crm/services/order_database_services.dart';
import 'package:dennis_lechon_crm/widgets/style.dart';
//import 'package:dennis_lechon_crm/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dennis_lechon_crm/screens/order_screen/order_list/edit_order.dart';
import 'package:intl/intl.dart';

class OrderInfo extends StatefulWidget {
  const OrderInfo({Key? key, required this.order, required this.firestore})
      : super(key: key);
  final Order order;
  final FirebaseFirestore firestore;

  @override
  State<OrderInfo> createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  final format = DateFormat("EEE, dd-MMM-yyyy, h:mm a");
  final ValueNotifier _isLoadingNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final smallLechonPrice = 5000 * widget.order.smallLechonCount;
    final mediumLechonPrice = 6000 * widget.order.mediumLechonCount;
    final largeLechonPrice = 7000 * widget.order.largeLechonCount;
    final extraLargeLechonPrice = 8000 * widget.order.extraLargeLechonCount;

    final subPrice = smallLechonPrice +
        mediumLechonPrice +
        largeLechonPrice +
        extraLargeLechonPrice;
    final totalPrice = subPrice + widget.order.deliveryFee;
    final totalItem = widget.order.smallLechonCount +
        widget.order.mediumLechonCount +
        widget.order.largeLechonCount +
        widget.order.extraLargeLechonCount;

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      contentPadding: const EdgeInsets.only(top: 0.0),
      insetPadding:
          const EdgeInsets.only(top: 50, bottom: 50, left: 10, right: 10),
      content: Column(
        children: [
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFD3231E),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 245, 246, 247),
                          ),
                          children: [
                            const TextSpan(
                              text: "Order ",
                            ),
                            TextSpan(
                              text: "#${widget.order.id.substring(0, 5)}",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 2.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.yellowColor),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.5),
                                  child: Text(
                                    format.format(widget.order.dateDelivery),
                                    style: const TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          (widget.order.isRush)
                              ? Container(
                                  margin: const EdgeInsets.only(right: 3.0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 2.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.yellowColor),
                                  child: Row(children: [
                                    const Icon(
                                      Icons.alarm,
                                      color: Colors.white,
                                      size: 14.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.5),
                                      child: Text("RUSH",
                                          style: GoogleFonts.mulish(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.0)),
                                    )
                                  ]),
                                )
                              : Container(),
                          Container(
                            margin: const EdgeInsets.only(right: 3.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 2.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.yellowColor),
                            child: Row(children: [
                              Icon(
                                (widget.order.isDelivery)
                                    ? Icons.delivery_dining_outlined
                                    : Icons.hail_outlined,
                                color: Colors.white,
                                size: 16.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.5),
                                child: Text(
                                    (widget.order.isDelivery)
                                        ? "DELIVERY"
                                        : "PICK-UP",
                                    style: GoogleFonts.mulish(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0)),
                              )
                            ]),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 3.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 2.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.yellowColor),
                            child: Row(children: [
                              const Icon(
                                Icons.account_balance_wallet_outlined,
                                // (widget.order.orderPaymentStatus == 'Paid')
                                //     ? Icons.check
                                //     : Icons.account_balance_wallet_outlined,
                                color: Colors.white,
                                size: 16.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.5),
                                child: Text(
                                    widget.order.orderPaymentStatus
                                        .toUpperCase(),
                                    style: GoogleFonts.mulish(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0)),
                              )
                            ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Positioned(
              //   right: 3.0,
              //   top: 5.0,
              //   child: InkResponse(
              //     radius: 17,
              //     onTap: () {
              //       Navigator.of(context).pop();
              //     },
              //     child: const CircleAvatar(
              //       radius: 17,
              //       backgroundColor: Color.fromARGB(255, 173, 23, 18),
              //       child: Icon(
              //         Icons.close,
              //         color: Colors.white,
              //         size: 23.0,
              //       ),
              //     ),
              //   ),
              // ),
              Positioned(
                right: 10,
                top: 10,
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: 17,
                          backgroundColor: Color.fromARGB(255, 189, 25, 20),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 17,
                          ),
                        ))),
              ),
            ],
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                child: Column(
                  children: [
                    // name & contact
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Name:',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                '${widget.order.firstName} ${widget.order.lastName}',
                                style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14.0,
                                    color: Color(0xFF1F2426),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        //SizedBox(width: 230, height: 0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Contact Number:',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                widget.order.contact,
                                style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14.0,
                                    color: Color(0xFF1F2426),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10.0),

                    // address
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Address',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              widget.order.address,
                              style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14.0,
                                  color: Color(0xFF1F2426),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                      ],
                    ),

                    const SizedBox(height: 25.0),

                    const Text(
                      'Order Details',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 17.0,
                          color: Color(0xFF1F2426),
                          fontWeight: FontWeight.w500),
                    ),

                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Card(
                                color: const Color.fromARGB(255, 243, 243, 243),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 3,
                                margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 20.0),
                                  child: Column(
                                    children: <Widget>[
                                      orderWidget(
                                          "Small Lechon",
                                          "(Php 5000)",
                                          "${widget.order.smallLechonCount}",
                                          "$smallLechonPrice"),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      orderWidget(
                                          "Medium Lechon",
                                          "(Php 6000)",
                                          "${widget.order.mediumLechonCount}",
                                          "$mediumLechonPrice"),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      orderWidget(
                                          "Large Lechon",
                                          "(Php 7000)",
                                          "${widget.order.largeLechonCount}",
                                          "$largeLechonPrice"),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      orderWidget(
                                          "XL Lechon",
                                          "(Php 8000)",
                                          "${widget.order.extraLargeLechonCount}",
                                          "$extraLargeLechonPrice"),

                                      const SizedBox(height: 20.0),

                                      // subtotal & delivery
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Expanded(
                                                  flex: 4,
                                                  child: Text(
                                                    "Subtotal",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 13,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 6,
                                                  child: Text(
                                                    //without backend yet
                                                    "Php $subPrice",
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 13,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5.0),
                                            Row(
                                              children: [
                                                const Expanded(
                                                  flex: 4,
                                                  child: Text(
                                                    "Delivery Fee",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 13,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 6,
                                                  child: Text(
                                                    "Php ${widget.order.deliveryFee}",
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 13,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 20),

                                      // the line
                                      Container(
                                        width: 250,
                                        height: 2,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 221, 220, 220),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 207, 206, 206),
                                              offset: Offset(0.0, 2.0),
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 20),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 5,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Total ",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 15.0,
                                                          color: Color.fromARGB(
                                                              255, 29, 29, 29),
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    Text(
                                                      '($totalItem items)',
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: Color.fromARGB(
                                                            255, 80, 79, 79),
                                                        letterSpacing: 0,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 5,
                                                child: Text(
                                                  'Php $totalPrice',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: Color.fromARGB(
                                                        255, 80, 79, 79),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 30.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xFFD3231E),
                                onPrimary: Colors.white,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                padding: const EdgeInsets.all(2),
                                fixedSize: const Size(150, 5),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                child: Text('Edit',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 12.0,
                                      color: Colors.white,
                                    )),
                              ),
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => EditOrder(
                                              order: widget.order,
                                              firestore: widget.firestore,
                                            ))));
                              },
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFFD3231E),
                                  onPrimary: Colors.white,
                                  elevation: 5,
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(8.0),
                                  minimumSize: const Size(10, 2),
                                ),
                                child: const Icon(Icons.delete_forever_rounded),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              "Delete Order#${widget.order.id.substring(0, 5)}?"),
                                          content: const Text(
                                              "Are you sure you want to delete this order? You cannot undo this action."),
                                          actions: [
                                            ValueListenableBuilder(
                                                valueListenable:
                                                    _isLoadingNotifier,
                                                builder:
                                                    (context, _isLoading, _) {
                                                  return TextButton(
                                                      onPressed: (_isLoading ==
                                                              true)
                                                          ? null
                                                          : () async {
                                                              _isLoadingNotifier
                                                                  .value = true;
                                                              await OrderService()
                                                                  .deleteOrder(
                                                                      widget
                                                                          .order
                                                                          .customerId,
                                                                      widget
                                                                          .order
                                                                          .id)
                                                                  .then(
                                                                      (value) {
                                                                debugPrint(
                                                                    "Order delete successful! (${widget.order.customerId})(${widget.order.id})");
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(const SnackBar(
                                                                        content:
                                                                            Text('Order was deleted successfully!')));
                                                                _isLoadingNotifier
                                                                        .value =
                                                                    false;
                                                              }).onError((error,
                                                                      stackTrace) {
                                                                debugPrint(
                                                                    "Order delete failed");
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(const SnackBar(
                                                                        content:
                                                                            Text('Order deletion failed.')));
                                                                _isLoadingNotifier
                                                                        .value =
                                                                    false;
                                                              });
                                                            },
                                                      child: const Text(
                                                          "Confirm"));
                                                }),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Cancel"))
                                          ],
                                        );
                                      });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget orderWidget(String name, String size, String amt, String price) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                name,
                style: GoogleFonts.mulish(
                  color: const Color.fromARGB(255, 71, 71, 71),
                  fontWeight: FontWeight.w700,
                  fontSize: 13.0,
                ),
              ),
              Text(
                size,
                style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
        Expanded(
          //diri emmaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
          flex: 2,
          child: RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 71, 71, 71)),
              children: [
                TextSpan(
                  text: amt,
                ),
                const TextSpan(
                    text: "x",
                    style: TextStyle(
                      fontSize: 11,
                    ))
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            price,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    ),
  );
}
