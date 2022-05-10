import 'package:dennis_lechon_crm/models/order.dart';
import 'package:dennis_lechon_crm/services/order_database_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderInfo extends StatefulWidget {
  const OrderInfo({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  State<OrderInfo> createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
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
                  height: 105,
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
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 245, 246, 247),
                          ),
                          children: [
                            TextSpan(
                              text: "#${widget.order.id.substring(0, 5)}",
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                color: const Color.fromARGB(255, 245, 246, 247),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'To be delivered on:  ',
                            style: GoogleFonts.montserrat(
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
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          text: widget.order.deliveryType ? "RUSH  " : "",
                          style: const TextStyle(
                              fontSize: 13.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                          children: const [
                            TextSpan(
                              text: 'ACTIVE',
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.0,
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
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
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 120),
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
                                Text(
                                  'Name:',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  '${widget.order.firstName} ${widget.order.lastName}',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15.0,
                                      color: const Color(0xFF1F2426),
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
                                Text(
                                  'Contact Number:',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  widget.order.celNum,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15.0,
                                      color: const Color(0xFF1F2426),
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
                              Text(
                                'Address',
                                style: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                '${widget.order.adrBarangay} ${widget.order.adrCity}',
                                style: GoogleFonts.montserrat(
                                    fontSize: 15.0,
                                    color: const Color(0xFF1F2426),
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
                                Text(
                                  'Order Details',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 21.0,
                                      color: const Color(0xFF1F2426),
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
                                          const SizedBox(height: 4),
                                          const Divider(
                                            color: Colors.grey,
                                            thickness: 5,
                                            indent: 14,
                                            endIndent: 14,
                                          ),
                                          const SizedBox(height: 4),
                                          RichText(
                                            text: TextSpan(
                                              text: 'Total',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 18.0,
                                                  color: const Color.fromARGB(
                                                      255, 29, 29, 29),
                                                  fontWeight: FontWeight.w700),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '  ($totalItem items)  ',
                                                  style: GoogleFonts.montserrat(
                                                    color: const Color.fromARGB(
                                                        255, 80, 79, 79),
                                                    letterSpacing: 1.0,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '                  Php $subPrice',
                                                  style: GoogleFonts.montserrat(
                                                    color: const Color.fromARGB(
                                                        255, 80, 79, 79),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w800,
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
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 2.0),
                                  child: Text('Edit',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      )),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
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
                                          title: Text("Delete Order#${widget.order.id.substring(0,5)}?"),
                                          content: const Text("Are you sure you want to delete this order? You cannot undo this action."),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                await OrderService().deleteOrder(
                                                  widget.order.customerid, 
                                                  widget.order.id
                                                ).then((value) {
                                                  debugPrint("Order delete successful!");
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text('Order was deleted successfully!')
                                                    )
                                                  );
                                                }).onError((error, stackTrace) {
                                                  debugPrint("Order delete failed");
                                                  Navigator.of(context).pop();
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text('Order deletion failed.')
                                                    )
                                                  );
                                                });
                                              },
                                              child: const Text("Confirm")
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Cancel")
                                            )
                                          ],
                                        );
                                      }
                                    );
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
              width: 45,
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
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(width: 15),
            Text(
              amt,
              style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 71, 71, 71)),
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              price,
              style: GoogleFonts.montserrat(
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
