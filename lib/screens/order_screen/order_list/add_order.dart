import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({Key? key}) : super(key: key);

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  var smallLechonItemCount = 0;
  var mediumLechonItemCount = 0;
  var largeLechonItemCount = 0;
  var extraLargeLechonItemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Order Fillout"),
          backgroundColor: const Color(0xFFD3231E),
          centerTitle: true,
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color.fromARGB(255, 236, 223, 149),
            ),
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: Colors.greenAccent,
                    width: double.infinity,
                    height: 100.0,
                  ),
                  Flex(direction: Axis.horizontal, children: [
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
                            color: const Color.fromARGB(255, 243, 243, 243),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 3,
                            margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: FittedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    orderWidget("Whole Lechon", "(Small)",
                                        smallLechonItemCount, "5000"),
                                    orderWidget("Whole Lechon", "(Medium)",
                                        mediumLechonItemCount, "5000"),
                                    orderWidget("Whole Lechon", "(Large)",
                                        largeLechonItemCount, "5000"),
                                    orderWidget("Whole Lechon", "(Extra Large)",
                                        extraLargeLechonItemCount, "5000"),
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
                                            text: '  (3 items)  ',
                                            style: GoogleFonts.montserrat(
                                              color: const Color.fromARGB(
                                                  255, 80, 79, 79),
                                              letterSpacing: 1.0,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '                  Php 20000',
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
                    ),
                  ])
                ])));
  }

  SizedBox orderWidget(String name, String size, int itemCount, String price) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 100,
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
              SizedBox(
                width: 30,
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0)),
                    primary: Colors.red.shade300,
                  ),
                  child: const Text(
                    "-",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    setState(() {
                      itemCount -= 1;
                    });
                    //print(itemCount);
                  },
                ),
              ),
              SizedBox(
                  width: 30,
                  height: 30,
                  child: Text(
                    itemCount.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              SizedBox(
                width: 30,
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0)),
                    primary: Colors.red.shade300,
                  ),
                  child: const Text(
                    "+",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    setState(() {
                      itemCount++;
                    });
                    //print(itemCount);
                  },
                ),
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
}
