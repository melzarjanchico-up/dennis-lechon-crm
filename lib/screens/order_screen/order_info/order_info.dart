import 'package:dennis_lechon_crm/models/order.dart';
import 'package:flutter/material.dart';

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
                const Positioned(
                  top: 10,
                  right: 22,
                  child: Text(
                    "#2891382 ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 209, 205, 205),
                        letterSpacing: 1.0,
                        fontSize: 13,
                        fontWeight: FontWeight.w900),
                  ),
                ),
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
                          style: const TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.0,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                          children: [
                            TextSpan(
                              text: "#${widget.order.id.substring(0, 5)}",
                              style: const TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.0,
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'To be delivered on:     \u{1F4D9}${widget.order.deliveryDate}   ',
                        style: const TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w100),
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
                              fontWeight: FontWeight.w900),
                          children: const [
                            TextSpan(
                              text: '\u{2705} ACTIVE',
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
                                const Text(
                                  'Name:',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  '${widget.order.firstName} ${widget.order.lastName}',
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
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
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  widget.order.celNum,
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
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
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                '${widget.order.adrBarangay} ${widget.order.adrCity}',
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
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
                                      fontSize: 25.0,
                                      color: Colors.black,
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
                                          const SizedBox(height: 8),
                                          RichText(
                                            text: TextSpan(
                                              text: 'Total',
                                              style: const TextStyle(
                                                  fontSize: 18.0,
                                                  color: Color.fromARGB(
                                                      255, 29, 29, 29),
                                                  fontWeight: FontWeight.w900),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '  ($totalItem items)  ',
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 80, 79, 79),
                                                    letterSpacing: 1.0,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '                  Php $subPrice',
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 80, 79, 79),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //middleSection,
                                          //rightSection,
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
                                    Navigator.pop(context);
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
                  style: const TextStyle(
                    color: Color.fromARGB(255, 71, 71, 71),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  size,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(width: 15),
            Text(
              amt,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              price,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
