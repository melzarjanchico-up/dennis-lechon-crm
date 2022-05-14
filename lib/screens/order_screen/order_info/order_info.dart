import 'package:dennis_lechon_crm/models/order.dart';
import 'package:dennis_lechon_crm/services/order_database_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dennis_lechon_crm/screens/order_screen/order_list/edit_order.dart';

class OrderInfo extends StatefulWidget {
  const OrderInfo({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  State<OrderInfo> createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  final ValueNotifier _isLoadingNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final smallLechonPrice = 5000 * widget.order.smallLechon;
    final mediumLechonPrice = 6000 * widget.order.mediumLechon;
    final largeLechonPrice = 7000 * widget.order.largeLechon;
    final extraLargeLechonPrice = 8000 * widget.order.extraLargeLechon;

    final subPrice = smallLechonPrice +
        mediumLechonPrice +
        largeLechonPrice +
        extraLargeLechonPrice;
    final totalItem = widget.order.smallLechon +
        widget.order.mediumLechon +
        widget.order.largeLechon +
        widget.order.extraLargeLechon as int;

    return AlertDialog(
      key: const Key("Order Info Card"),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      contentPadding: const EdgeInsets.only(top: 0.0),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 115,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD3231E),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          text: "Order ",
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 245, 246, 247),
                          ),
                          children: [
                            TextSpan(
                              text: "#${widget.order.id.substring(0, 5)}",
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 245, 246, 247),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'To be delivered on:  ',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w200),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xFFF1A22C)),
                            child: Text(
                              widget.order.deliveryDate,
                              style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          text: widget.order.deliveryType
                              ? "\u{26A1} RUSH  "
                              : "",
                          style: const TextStyle(
                              fontSize: 13.0,
                              color: Colors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w900),
                          children: const [
                            TextSpan(
                              text: '\u{2705} ACTIVE',
                              style: TextStyle(
                                fontFamily: 'Oxygen',
                                color: Colors.white,
                                letterSpacing: 1,
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 3.0,
                  top: 5.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      radius: 17,
                      backgroundColor: Color.fromARGB(255, 173, 23, 18),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 23.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 130),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //SizedBox(height: 250),
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
                                      fontSize: 15.0,
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
                                  widget.order.celNum,
                                  style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 15.0,
                                      color: Color(0xFF1F2426),
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
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
                                '${widget.order.adrBarangay} ${widget.order.adrCity}',
                                style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15.0,
                                    color: Color(0xFF1F2426),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                        ],
                      ),
                      const SizedBox(height: 25.0),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  'Order Details',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 23.0,
                                      color: Color(0xFF1F2426),
                                      fontWeight: FontWeight.w500),
                                ),
                                Card(
                                  color:
                                      const Color.fromARGB(255, 243, 243, 243),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 3,
                                  margin:
                                      const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: FittedBox(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          orderWidget(
                                              "Whole Lechon",
                                              "(Small)",
                                              "${widget.order.smallLechon}x",
                                              "$smallLechonPrice"),
                                          orderWidget(
                                              "Whole Lechon",
                                              "(Medium)",
                                              "${widget.order.mediumLechon}x",
                                              "$mediumLechonPrice"),
                                          orderWidget(
                                              "Whole Lechon",
                                              "(Large)",
                                              "${widget.order.largeLechon}x",
                                              "$largeLechonPrice"),
                                          orderWidget(
                                              "Whole Lechon",
                                              "(Extra Large)",
                                              "${widget.order.extraLargeLechon}x",
                                              "$extraLargeLechonPrice"),
                                          const SizedBox(height: 3),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    "Subtotal",
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(width: 25),
                                                  Text(
                                                    //without backend yet
                                                    "Php 10,000",
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    "Delivery fee",
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(width: 25),
                                                  Text(
                                                    //without backend yet
                                                    "Php 500",
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              const SizedBox(height: 20),
                                              //dedeliver
                                              Row(
                                                children: [
                                                  const SizedBox(width: 27),
                                                  Container(
                                                    width: 250,
                                                    height: 2,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              221,
                                                              220,
                                                              220),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Color.fromARGB(
                                                              255,
                                                              207,
                                                              206,
                                                              206),
                                                          offset:
                                                              Offset(0.0, 2.0),
                                                          blurRadius: 2,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            children: [
                                              const SizedBox(width: 20),
                                              RichText(
                                                text: TextSpan(
                                                  text: 'Total',
                                                  style: const TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 18.0,
                                                      color: Color.fromARGB(
                                                          255, 29, 29, 29),
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          '  ($totalItem items)  ',
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: Color.fromARGB(
                                                            255, 80, 79, 79),
                                                        letterSpacing: 1.0,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '      Php $subPrice',
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: Color.fromARGB(
                                                            255, 80, 79, 79),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
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
                                  padding: const EdgeInsets.all(15.0),
                                  minimumSize: const Size(15, 5),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 2.0),
                                  child: Text('Edit',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      )),
                                ),
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const EditOrder(
                                                  // order: order,
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
                                    padding: const EdgeInsets.all(15.0),
                                    minimumSize: const Size(15, 5),
                                  ),
                                  child:
                                      const Icon(Icons.delete_forever_rounded),
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
                                                        onPressed:
                                                            (_isLoading == true)
                                                                ? null
                                                                : () async {
                                                                    _isLoadingNotifier
                                                                            .value =
                                                                        true;
                                                                    await OrderService()
                                                                        .deleteOrder(
                                                                            widget
                                                                                .order.customerid,
                                                                            widget
                                                                                .order.id)
                                                                        .then(
                                                                            (value) {
                                                                      debugPrint(
                                                                          "Order delete successful!");
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              const SnackBar(content: Text('Order was deleted successfully!')));
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
                                                                          .showSnackBar(
                                                                              const SnackBar(content: Text('Order deletion failed.')));
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

SizedBox orderWidget(String name, String size, String amt, String price) {
  return SizedBox(
    height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 55,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  style: GoogleFonts.mulish(
                    color: const Color.fromARGB(255, 71, 71, 71),
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  size,
                  style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(width: 15),
            Text(
              amt,
              style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 71, 71, 71)),
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              price,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
