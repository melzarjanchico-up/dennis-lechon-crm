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
  var itemCount = 0;

  //Pricing
  var smallLechonPrice = 0;
  var mediumLechonPrice = 0;
  var largeLechonPrice = 0;
  var extraLargeLechonPrice = 0;

  //Fees
  var deliveryFee = 0; // kindly put UI for this;
  var subTotal = 0;
  var totalFee = 0;

  //Mu error pa ni siya kay ni lapas daw ang Pixels po
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Kuwangan nig back button
        appBar: AppBar(
          title: const Text("Order Fillout"),
          backgroundColor: const Color(0xFFD3231E),
          centerTitle: true,
        ),
        // This is the yellow part na container
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
                  //Green Part..This was suppost to be the customer details part. Basta katung upper part na UI sa figma
                  Container(
                    color: Colors.greenAccent,
                    width: double.infinity,
                    height: 100.0,
                  ),
                  //Order Details Part
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
                                  //
                                  // This is the start of the elements sa Card UI
                                  //
                                  children: <Widget>[
                                    SizedBox(
                                      height: 60,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 100,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Whole Lechon",
                                                    style: GoogleFonts.mulish(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 71, 71, 71),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "(Small)",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 15),
                                              SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0.0)),
                                                      primary:
                                                          Colors.red.shade300,
                                                    ),
                                                    child: const Text(
                                                      "-",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        smallLechonItemCount !=
                                                                0
                                                            ? smallLechonItemCount--
                                                            : 0;
                                                        smallLechonPrice != 0
                                                            ? smallLechonPrice -=
                                                                5000
                                                            : 0;
                                                        itemCount != 0
                                                            ? itemCount -= 1
                                                            : 0;
                                                        subTotal != 0
                                                            ? subTotal -= 5000
                                                            : 0;
                                                        totalFee != 0
                                                            ? totalFee -= 5000
                                                            : 0;
                                                      });
                                                    }),
                                              ),
                                              SizedBox(
                                                  width: 30,
                                                  height: 30,
                                                  child: Text(
                                                    smallLechonItemCount
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                              // ignore: avoid_print
                                              SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.0)),
                                                    primary:
                                                        Colors.red.shade300,
                                                  ),
                                                  child: const Text(
                                                    "+",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      smallLechonItemCount++;
                                                      smallLechonPrice += 5000;
                                                      subTotal += 5000;
                                                      totalFee += 5000;
                                                      itemCount++;
                                                    });
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 25,
                                              ),
                                              Text(
                                                smallLechonPrice.toString(),
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 100,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Whole Lechon",
                                                    style: GoogleFonts.mulish(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 71, 71, 71),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "(Medium)",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 15),
                                              SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0.0)),
                                                      primary:
                                                          Colors.red.shade300,
                                                    ),
                                                    child: const Text(
                                                      "-",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        mediumLechonItemCount !=
                                                                0
                                                            ? mediumLechonItemCount--
                                                            : 0;
                                                        mediumLechonPrice != 0
                                                            ? mediumLechonPrice -=
                                                                6000
                                                            : 0;
                                                        itemCount != 0
                                                            ? itemCount -= 1
                                                            : 0;
                                                        subTotal != 0
                                                            ? subTotal -= 6000
                                                            : 0;
                                                        totalFee != 0
                                                            ? totalFee -= 6000
                                                            : 0;
                                                      });
                                                    }),
                                              ),
                                              SizedBox(
                                                  width: 30,
                                                  height: 30,
                                                  child: Text(
                                                    mediumLechonItemCount
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                              // ignore: avoid_print
                                              SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.0)),
                                                    primary:
                                                        Colors.red.shade300,
                                                  ),
                                                  child: const Text(
                                                    "+",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      mediumLechonItemCount++;
                                                      mediumLechonPrice += 6000;
                                                      subTotal += 6000;
                                                      totalFee += 6000;
                                                      itemCount++;
                                                    });
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 25,
                                              ),
                                              Text(
                                                mediumLechonPrice.toString(),
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 100,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Whole Lechon",
                                                    style: GoogleFonts.mulish(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 71, 71, 71),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "(Large)",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 15),
                                              SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0.0)),
                                                      primary:
                                                          Colors.red.shade300,
                                                    ),
                                                    child: const Text(
                                                      "-",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        largeLechonItemCount !=
                                                                0
                                                            ? largeLechonItemCount--
                                                            : 0;
                                                        largeLechonPrice != 0
                                                            ? largeLechonPrice -=
                                                                7000
                                                            : 0;
                                                        itemCount != 0
                                                            ? itemCount -= 1
                                                            : 0;
                                                        subTotal != 0
                                                            ? subTotal -= 7000
                                                            : 0;
                                                        totalFee != 0
                                                            ? totalFee -= 7000
                                                            : 0;
                                                      });
                                                    }),
                                              ),
                                              SizedBox(
                                                  width: 30,
                                                  height: 30,
                                                  child: Text(
                                                    largeLechonItemCount
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                              // ignore: avoid_print
                                              SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.0)),
                                                    primary:
                                                        Colors.red.shade300,
                                                  ),
                                                  child: const Text(
                                                    "+",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      largeLechonItemCount++;
                                                      largeLechonPrice += 7000;
                                                      subTotal += 7000;
                                                      totalFee += 7000;
                                                      itemCount++;
                                                    });
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 25,
                                              ),
                                              Text(
                                                largeLechonPrice.toString(),
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 100,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Whole Lechon",
                                                    style: GoogleFonts.mulish(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 71, 71, 71),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "(Extra Large)",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 15),
                                              SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0.0)),
                                                      primary:
                                                          Colors.red.shade300,
                                                    ),
                                                    child: const Text(
                                                      "-",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        extraLargeLechonItemCount !=
                                                                0
                                                            ? extraLargeLechonItemCount--
                                                            : 0;
                                                        extraLargeLechonPrice !=
                                                                0
                                                            ? extraLargeLechonPrice -=
                                                                8000
                                                            : 0;
                                                        itemCount != 0
                                                            ? itemCount -= 1
                                                            : 0;
                                                        subTotal != 0
                                                            ? subTotal -= 8000
                                                            : 0;
                                                        totalFee != 0
                                                            ? totalFee -= 8000
                                                            : 0;
                                                      });
                                                    }),
                                              ),
                                              SizedBox(
                                                  width: 30,
                                                  height: 30,
                                                  child: Text(
                                                    extraLargeLechonItemCount
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                              // ignore: avoid_print
                                              SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.0)),
                                                    primary:
                                                        Colors.red.shade300,
                                                  ),
                                                  child: const Text(
                                                    "+",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      extraLargeLechonItemCount++;
                                                      extraLargeLechonPrice +=
                                                          8000;
                                                      subTotal += 8000;
                                                      totalFee += 8000;
                                                    });
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 25,
                                              ),
                                              Text(
                                                extraLargeLechonPrice
                                                    .toString(),
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
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
                                            text: itemCount > 1
                                                ? '  ($itemCount items)  '
                                                : '  ($itemCount item)  ',
                                            style: GoogleFonts.montserrat(
                                              color: const Color.fromARGB(
                                                  255, 80, 79, 79),
                                              letterSpacing: 1.0,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '                  $subTotal',
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
}
