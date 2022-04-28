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
    final leftSection = Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const <Widget>[
            Text(
              "Whole Lechon",
              style: TextStyle(
                color: Color.fromARGB(255, 80, 79, 79),
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
            Text(
              "(Small)",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 25),
            Text(
              "Whole Lechon",
              style: TextStyle(
                color: Color.fromARGB(255, 65, 64, 64),
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
            Text(
              "(Medium)",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 25),
            Text(
              "Whole Lechon",
              style: TextStyle(
                color: Color.fromARGB(255, 71, 71, 71),
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
            Text(
              "(Large)",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 25),
            Text(
              "Whole Lechon",
              style: TextStyle(
                color: Color.fromARGB(255, 71, 71, 71),
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
            Text(
              "(Extra Large)",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );

    final middleSection = Expanded(
      child: Container(
        padding: const EdgeInsets.only(right: 5.0),
        child: Column(
          children: <Widget>[
            Text(
              widget.order.smallLechon.toString(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              widget.order.mediumLechon.toString(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              widget.order.largeLechon.toString(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              widget.order.extraLargeLechon.toString(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );

    final rightSection = Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "$smallLechonPrice",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              "$mediumLechonPrice",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              "$largeLechonPrice",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              "$extraLargeLechonPrice",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
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
                          text:
                              widget.order.deliveryType ? "\u{26A1} RUSH" : "",
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
                            )
                          ),
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
                                const SizedBox(height: 5.0),
                                Card(
                                  color: const Color.fromARGB(255, 243, 243, 243),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: <Widget>[
                                            leftSection,
                                            middleSection,
                                            rightSection,
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 30.0),
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'Total',
                                              style: const TextStyle(
                                                  fontSize: 18.0,
                                                  color: Color.fromARGB(255, 29, 29, 29),
                                                  fontWeight: FontWeight.w900),
                                              children: [
                                                TextSpan(
                                                  text: '($totalItem items)',
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(255, 80, 79, 79),
                                                    letterSpacing: 1.0,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'Php $subPrice',
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(255, 80, 79, 79),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                    )
                                  ),
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
                                  child: const Icon(Icons.delete_forever_rounded),
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
