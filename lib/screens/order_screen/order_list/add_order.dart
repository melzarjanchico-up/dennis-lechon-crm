import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/add_customer_new.dart';
//import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/add_customer_new.dart';
import 'package:dennis_lechon_crm/services/customer_database_services.dart';
//import 'package:dennis_lechon_crm/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:dennis_lechon_crm/widgets/search.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({Key? key, required this.firestore}) : super(key: key);
  final FirebaseFirestore firestore;

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  int smallLechonItemCount = 0;
  int mediumLechonItemCount = 0;
  int largeLechonItemCount = 0;
  int extraLargeLechonItemCount = 0;
  int itemCount = 0;

  //Pricing
  double smallLechonPrice = 0;
  double mediumLechonPrice = 0;
  double largeLechonPrice = 0;
  double extraLargeLechonPrice = 0;

  //Fees
  double deliveryFee = 0;
  double subTotal = 0;
  double totalFee = 0;

  Customer? chosenCustomer;
  DateTime? _deliveryDateController;
  String? _orderStatusController;
  String? _orderPaymentMethodController;

  bool _isRushOrder = false;
  bool _isDeliveryOrder = false;

  final TextEditingController _searchCustomerController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _deliveryFee = TextEditingController(text: '');


  //Mu error pa ni siya kay ni lapas daw ang Pixels po
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 235, 235),
        //Kuwangan nig back button
        appBar: AppBar(
          title: const Text("Order Fillout"),
          backgroundColor: const Color(0xFFD3231E),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Colors.white,
          ),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [

              orderInfoDeets(),
              const SizedBox(width: 10),
              customerInfoDeets(),
              const SizedBox(height: 20),

              //Order Details Part
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                                fontWeight: FontWeight.w500
                              ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    //
                                    // This is the start of the elements sa Card UI
                                    //
                                    children: <Widget>[
                                      smallLechonWidget(
                                        5000,
                                        "Small"
                                      ),
                                      const SizedBox(height: 10),
                                      mediumLechonWidget(
                                        6000,
                                        "Medium"
                                      ),
                                      const SizedBox(height: 10),
                                      largeLechonWidget(
                                        7000,
                                        "Large"
                                      ),
                                      const SizedBox(height: 10),
                                      xlargeLechonWidget(
                                        8000,
                                        "Extra Large"
                                      ),
                                      const SizedBox(height: 20),
                                      
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              const Text(
                                                "Subtotal",
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(width: 25),
                                              Text(
                                                //without backend yet
                                                "Php $subTotal",
                                                style: const TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),

                                          (_isDeliveryOrder) ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Delivery fee",
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              const Text(
                                                "Php",
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: 65,
                                                height: 20,
                                                child: TextField(
                                                  enabled: _isDeliveryOrder,
                                                  textAlign: TextAlign.end,
                                                  controller: _deliveryFee,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      if (value != '') {
                                                        totalFee = (subTotal + int.parse(value));
                                                      } else {
                                                        totalFee = subTotal;
                                                      }
                                                    });
                                                  },
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [
                                                    //LengthLimitingTextInputFormatter(11),
                                                    FilteringTextInputFormatter.digitsOnly,
                                                  ],
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  decoration: const InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            14, 0, 0, 0),
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ): Container(),

                                          const SizedBox(height: 20),

                                          Row(
                                            children: [
                                              const SizedBox(width: 25),
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
                                              const SizedBox(width: 5),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(width: 20),
                                          Container(
                                            width: 300,
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
                                          const SizedBox(width: 3.5),
                                        ],
                                      ),
                                      const SizedBox(height: 22),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(width: 30),
                                          Text(
                                            'Total',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 18.0,
                                                color: const Color.fromARGB(
                                                    255, 29, 29, 29),
                                                fontWeight: FontWeight.w700),
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            itemCount > 1
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
                                          const SizedBox(width: 25),
                                          Text(
                                            'Php',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 18.0,
                                                color: const Color.fromARGB(
                                                    255, 80, 79, 79),
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            '  $totalFee',
                                            style: GoogleFonts.montserrat(
                                              color: const Color.fromARGB(
                                                  255, 80, 79, 79),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            ElevatedButton(
                              child: const Text(' Create Order ',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  )),
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                primary: const Color(0xFFF1A22C),
                                onPrimary: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 34, vertical: 20),
                              ),
                            ),

                            const SizedBox(height: 15),

                          ],
                        ),
                      ),
                    ]
                  ),
                ],
              )

            ]),
          )
        )
      );
    }

  // small lechon
  Widget smallLechonWidget(int basePrice, String name) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Whole Lechon",
                        style: GoogleFonts.mulish(
                          color: const Color.fromARGB(255,71,71,71),
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "($name)",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFD3231E),
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: const Color(0xFFD3231E)
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(40, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)
                              ),
                              primary: const Color.fromARGB(255,243,243,243),
                            ),
                            child: const Text(
                              "-",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD3231E)
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                if (smallLechonItemCount > 0) {
                                  smallLechonItemCount--;
                                  smallLechonPrice-=basePrice;

                                  itemCount--;
                                  subTotal-=basePrice;
                                  totalFee-=basePrice;
                                }
                              });
                            }
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          smallLechonItemCount.toString(),
                          style: const TextStyle(
                            color:Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: const Color(0xFFD3231E)
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(40, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)
                              ),
                              primary: const Color.fromARGB(255,243,243,243),
                            ),
                            child: const Text(
                              "+",
                              style: TextStyle(
                                color: Color(0xFFD3231E),
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                smallLechonItemCount++;
                                smallLechonPrice += basePrice;

                                subTotal += basePrice;
                                totalFee += basePrice;
                                itemCount++;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
    );
  }

  // medium lechon
  Widget mediumLechonWidget(int basePrice, String name) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Whole Lechon",
                        style: GoogleFonts.mulish(
                          color: const Color.fromARGB(255,71,71,71),
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "($name)",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFD3231E),
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: const Color(0xFFD3231E)
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(40, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)
                              ),
                              primary: const Color.fromARGB(255,243,243,243),
                            ),
                            child: const Text(
                              "-",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD3231E)
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                if (mediumLechonItemCount > 0) { // !here
                                  mediumLechonItemCount--; // ! here
                                  mediumLechonPrice-=basePrice; // ! here

                                  itemCount--;
                                  subTotal-=basePrice;
                                  totalFee-=basePrice;
                                }
                              });
                            }
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          mediumLechonItemCount.toString(), // ! here
                          style: const TextStyle(
                            color:Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: const Color(0xFFD3231E)
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(40, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)
                              ),
                              primary: const Color.fromARGB(255,243,243,243),
                            ),
                            child: const Text(
                              "+",
                              style: TextStyle(
                                color: Color(0xFFD3231E),
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                mediumLechonItemCount++;
                                mediumLechonPrice += basePrice;

                                subTotal += basePrice;
                                totalFee += basePrice;
                                itemCount++;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                mediumLechonPrice.toString(), // ! here
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

  // large lechon
  Widget largeLechonWidget(int basePrice, String name) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Whole Lechon",
                        style: GoogleFonts.mulish(
                          color: const Color.fromARGB(255,71,71,71),
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "($name)",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFD3231E),
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: const Color(0xFFD3231E)
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(40, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)
                              ),
                              primary: const Color.fromARGB(255,243,243,243),
                            ),
                            child: const Text(
                              "-",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD3231E)
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                if (largeLechonItemCount > 0) { // !here
                                  largeLechonItemCount--; // ! here
                                  largeLechonPrice-=basePrice; // ! here

                                  itemCount--;
                                  subTotal-=basePrice;
                                  totalFee-=basePrice;
                                }
                              });
                            }
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          largeLechonItemCount.toString(), // ! here
                          style: const TextStyle(
                            color:Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: const Color(0xFFD3231E)
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(40, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)
                              ),
                              primary: const Color.fromARGB(255,243,243,243),
                            ),
                            child: const Text(
                              "+",
                              style: TextStyle(
                                color: Color(0xFFD3231E),
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                largeLechonItemCount++;
                                largeLechonPrice += basePrice;

                                subTotal += basePrice;
                                totalFee += basePrice;
                                itemCount++;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                largeLechonPrice.toString(), // ! here
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

  // x-large lechon
  Widget xlargeLechonWidget(int basePrice, String name) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Whole Lechon",
                        style: GoogleFonts.mulish(
                          color: const Color.fromARGB(255,71,71,71),
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "($name)",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFD3231E),
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: const Color(0xFFD3231E)
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(40, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)
                              ),
                              primary: const Color.fromARGB(255,243,243,243),
                            ),
                            child: const Text(
                              "-",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD3231E)
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                if (extraLargeLechonItemCount > 0) { // !here
                                  extraLargeLechonItemCount--; // ! here
                                  extraLargeLechonPrice-=basePrice; // ! here

                                  itemCount--;
                                  subTotal-=basePrice;
                                  totalFee-=basePrice;
                                }
                              });
                            }
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          extraLargeLechonItemCount.toString(), // ! here
                          style: const TextStyle(
                            color:Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: const Color(0xFFD3231E)
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(40, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)
                              ),
                              primary: const Color.fromARGB(255,243,243,243),
                            ),
                            child: const Text(
                              "+",
                              style: TextStyle(
                                color: Color(0xFFD3231E),
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                extraLargeLechonItemCount++; // !here
                                extraLargeLechonPrice += basePrice; // !here

                                subTotal += basePrice;
                                totalFee += basePrice;
                                itemCount++;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                extraLargeLechonPrice.toString(), // ! here
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

  // general order deets
  Widget orderInfoDeets() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 120.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          /*
          RichText(
            text: const TextSpan(
              text: "Order ",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2426),
              ),
              children: [
                TextSpan(
                  text: "# Order",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    //fontStyle: FontStyle.italic,
                    color: Color(0xFF1F2426),
                  ),
                ),
              ],
            ),
          ),*/

          //const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              // delivery date setter
              TextButton.icon(
                onPressed: () async {
                  await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          initialEntryMode: DatePickerEntryMode.input)
                      .then((value) {
                    setState(() {
                      _deliveryDateController = value;
                    });
                  }).onError((error, stackTrace) => null);
                },
                icon: const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.white,
                  size: 16.0,
                ),
                label: Text(
                  (_deliveryDateController != null)
                      ? '${_deliveryDateController!.month}/${_deliveryDateController!.day}/${_deliveryDateController!.year}'
                      : 'SET DATE',
                  style: const TextStyle(
                    //fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: 16.0),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  minimumSize: Size.zero,
                  backgroundColor: const Color(0xFF2A87BB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),
              ),

              const SizedBox(width: 10),

              // checkbox for rush order
              Checkbox(
                value: _isRushOrder,
                activeColor: const Color(0xFFF1A22C),
                onChanged: (val) {
                  setState(() {
                    _isRushOrder = (val!);
                  });
                },
              ),
              const Text(
                "RUSH?",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color(0xFF1F2426),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(width: 10),

              // checkbox for delivery order
              Checkbox(
                value: _isDeliveryOrder,
                activeColor: const Color(0xFFF1A22C),
                onChanged: (value) {
                  setState(() {
                    _isDeliveryOrder = (value!);
                  });
                  if (_isDeliveryOrder == false) {
                    totalFee = (totalFee - int.parse(_deliveryFee.text));
                    _deliveryFee.text = '';
                  }
                },
              ),
              const Text(
                "DELIVERY?",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color(0xFF1F2426),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

            ],
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                isDense: true,
                hint: _orderStatusController == null
                  ? const Text('Set Status')
                  : Text(
                      _orderStatusController!,
                      style: const TextStyle(color: Colors.blue),
                ),
                items: <String>['Unpaid', 'Paid'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _orderStatusController = val;
                  });
                  if (_orderStatusController == 'Paid') {
                    _orderPaymentMethodController = null;
                  }
                },
              ),
              const SizedBox(width: 10.0,),
              DropdownButton<String>(
                isDense: true,
                
                hint: (_orderPaymentMethodController == null) ? 
                  (_orderStatusController != 'Paid') ? const Text('Payment Method') : 
                    const Text(
                      'Already Paid', 
                      style: TextStyle(
                        color: Colors.red
                      ),
                    )
                  : Text(
                      _orderPaymentMethodController!,
                      style: const TextStyle(color: Colors.blue),
                ),

                items: <String>['Payment in Advance', 'Cash on Delivery', 'Online (e.g. GCash, etc.)', 'Others'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_orderStatusController == 'Unpaid') ? (val) {
                  setState(() {
                    _orderPaymentMethodController = val;
                  });
                } : null,
              ),
            ],
          )

        ],
      ),
    );
  }

  // customer information widhet
  Widget customerInfoDeets() {
    return Column(
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

        SizedBox(
          width: 350,
          child: TypeAheadFormField(
            hideOnLoading: true,
            textFieldConfiguration: TextFieldConfiguration(
              controller: _searchCustomerController,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.person_search_outlined),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 15)
              ),
            ),

            suggestionsCallback: (pattern) async {
              return CustomerService(firestore: widget.firestore).getSuggestion(pattern);
            },

            // frontend edit inside here if u want to edit the box itself
            suggestionsBoxDecoration: const SuggestionsBoxDecoration(
              constraints: BoxConstraints(
                maxHeight: 200.0
              )
            ),
            
            itemBuilder: (context, Customer customer) {
              return ListTile(
                title: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Container(
                          padding: const EdgeInsets.only(right: 2.5),
                          child: Icon(Icons.person_sharp, size: 14.0, color: customer.tagColor)
                        )
                      ),
                      TextSpan(
                        text: '${customer.firstName} ${customer.lastName}',
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          //color: Colors.grey,
                          //fontSize: 14.0,
                          fontWeight: FontWeight.w300
                        ),
                      )
                    ]
                  ),
                ),
                subtitle: Text(
                  '${customer.adrBarangay} ${customer.adrCity}',
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },

            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },

            onSuggestionSelected: (Customer customer) {
              setState(() {
                chosenCustomer = customer;
              });
              _searchCustomerController.text = '${customer.firstName} ${customer.lastName}';
              _addressController.text = (customer.adrStreet.isNotEmpty ? '${customer.adrStreet} ' : '') + 
                    (customer.adrBarangay.isNotEmpty ? '${customer.adrBarangay} ' : '') + 
                    (customer.adrCity.isNotEmpty ? '${customer.adrCity} ' : '') + 
                    (customer.adrProvince.isNotEmpty ? '${customer.adrProvince} ' : '') + 
                    (customer.adrZipcode.isNotEmpty ? '${customer.adrZipcode} ' : '');
              _contactController.text = customer.celNum;
            },

            noItemsFoundBuilder: (context) {
              return ListTile(
                title: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Container(
                          padding: const EdgeInsets.only(right: 2.5),
                          child: const Icon(Icons.person_add_alt, size: 14.0)
                        )
                      ),
                      const TextSpan(
                        text: 'This customer does not exist.',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          //color: Colors.grey,
                          fontWeight: FontWeight.w300
                        ),
                      )
                    ]
                  ),
                ),
                subtitle: const Text(
                  'Add this customer into the database!',
                ),
                onTap: (){
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddCustomer(firestore: widget.firestore,)));
                  },
              );
            },

            validator: (value) {
              if (value!.isEmpty) {
                return 'Please select a customer.';
              }
              return null;
            },

            //onSaved: (value) => _selectedCity = (value as String),

          )

        ),

        const SizedBox(height: 20),

        const Text(
          'Address:',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.grey,
              fontSize: 12.0,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(
          width: 350,
          child: TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // labelText: 'Name',
                contentPadding: EdgeInsets.symmetric(horizontal: 15)),
          ),
        ),
        const SizedBox(height: 20),

        const Text(
          'Contact Number:',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.grey,
              fontSize: 12.0,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(
          width: 350,
          child: TextFormField(
            controller: _contactController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // labelText: 'Name',
                contentPadding: EdgeInsets.symmetric(horizontal: 15)),
          ),
        ),

      ],
    );
  }

}