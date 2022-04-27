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
          children: const <Widget>[
            Text(
              "x2",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 50),
            Text(
              "x2",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 50),
            Text(
              "x1",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 50),
            Text(
              "x2",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );

    final rightSection = Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Text(
              "{Php 2,000.00}",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 50),
            Text(
              "Php 1,000.00",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 50),
            Text(
              "Php 2,000.00",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 50),
            Text(
              "Php 2,000.00",
              style: TextStyle(
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
                        text: const TextSpan(
                          text: "Order ",
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.0,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                          children: [
                            TextSpan(
                              text: "#28391829 ",
                              style: TextStyle(
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
                      const Text(
                        'To be delivered on:     \u{1F4D9}   ',
                        style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w100),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: const TextSpan(
                          text: '\u{26A1} RUSH    ',
                          style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                          children: [
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
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(height: 250),
                      Text(
                        'Name:',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(width: 230, height: 0),
                      Text(
                        'Contact Number:',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(height: 290),
                      Text(
                        'Emma Axe',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(width: 170, height: 0),
                      Text(
                        '0923101293',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 175),
                      Text(
                        'Address',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: 7),
                      Text(
                        'Minglanilla, Cebu',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Order Details',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
                Positioned(
                  top: 500,
                  left: 35,
                  child: RichText(
                    text: const TextSpan(
                      text: 'Total',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Color.fromARGB(255, 29, 29, 29),
                          fontWeight: FontWeight.w900),
                      children: [
                        TextSpan(
                          text: '  (5 items)  ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 80, 79, 79),
                            letterSpacing: 1.0,
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: '                        Php 5,000',
                          style: TextStyle(
                            color: Color.fromARGB(255, 80, 79, 79),
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: const Color.fromARGB(255, 243, 243, 243),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 265.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        leftSection,
                        middleSection,
                        rightSection,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 50,
                  child: Row(
                    children: [
                      ElevatedButton(
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
                        child: const Text('   Edit   ',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 75),
                      ElevatedButton(
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
