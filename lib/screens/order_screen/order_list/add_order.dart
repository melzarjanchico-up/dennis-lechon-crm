import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/add_customer_new.dart';
//import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/add_customer_new.dart';
import 'package:dennis_lechon_crm/services/customer_database_services.dart';
import 'package:dennis_lechon_crm/services/order_database_services.dart';
import 'package:dennis_lechon_crm/widgets/reusable_widget.dart';
//import 'package:dennis_lechon_crm/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:dennis_lechon_crm/widgets/search.dart';
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({Key? key, required this.firestore}) : super(key: key);
  final FirebaseFirestore firestore;

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("EEE, dd-MMM-yyyy, h:mma");
  final ValueNotifier _isLoadingNotifier = ValueNotifier(false);

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
  double subTotal = 0;
  double totalFee = 0;

  Customer? chosenCustomer;
  DateTime? _deliveryDateController;
  String? _orderStatusController;
  String? savedText = '';

  bool _isRushOrder = false;
  bool _isDeliveryOrder = false;

  List<String> paymentStatus = ['Paid', 'Unpaid', 'Delivered'];
  //List<String> paymentMethods = ['Payment in Advance', 'Cash on Delivery', 'Online (e.g. GCash, etc.)', 'Others'];

  final TextEditingController _searchCustomerController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _deliveryFee = TextEditingController(text: '');

  //Mu error pa ni siya kay ni lapas daw ang Pixels po
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_searchCustomerController.text == savedText &&
            _addressController.text == savedText &&
            _contactController.text == savedText &&
            _deliveryFee.text == savedText &&
            smallLechonItemCount == 0 &&
            mediumLechonItemCount == 0 &&
            largeLechonItemCount == 0 &&
            extraLargeLechonItemCount == 0 &&
            itemCount == 0) {
          return true;
        }
        final result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text("Are you sure?"),
                content: const Text("All unsaved changes would be lost."),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        primary: const Color.fromARGB(132, 211, 36, 30),
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                      ),
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.pop(context, false);
                      }),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        primary: const Color(0xFFD3231E),
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                      ),
                      child: const Text('Yes',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.pop(context, true);
                      }),
                ]);
          },
        );
        return result;
      },
      child: Scaffold(
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
              margin: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(height: 30),
                    customerOrderInfoDeets(),
                    const SizedBox(height: 30),

                    //Order Details Part
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                                  color:
                                      const Color.fromARGB(255, 243, 243, 243),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 3,
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: FittedBox(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        //
                                        // This is the start of the elements sa Card UI
                                        //
                                        children: <Widget>[
                                          smallLechonWidget(5000, "5000"),
                                          const SizedBox(height: 10),
                                          mediumLechonWidget(6000, "6000"),
                                          const SizedBox(height: 10),
                                          largeLechonWidget(7000, "7000"),
                                          const SizedBox(height: 10),
                                          xlargeLechonWidget(8000, "8000"),
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
                                                    "Php $subTotal",
                                                    style: const TextStyle(
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
                                              const SizedBox(width: 40),
                                              (_isDeliveryOrder)
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Delivery fee",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 12,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 25),
                                                        const Text(
                                                          "Php",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 14,
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        SizedBox(
                                                          width: 65,
                                                          height: 20,
                                                          child: TextField(
                                                            enabled:
                                                                _isDeliveryOrder,
                                                            textAlign:
                                                                TextAlign.end,
                                                            controller:
                                                                _deliveryFee,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                if (value !=
                                                                    '') {
                                                                  totalFee = (subTotal +
                                                                      int.parse(
                                                                          value));
                                                                } else {
                                                                  totalFee =
                                                                      subTotal;
                                                                }
                                                              });
                                                            },
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                              //LengthLimitingTextInputFormatter(11),
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly,
                                                            ],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            decoration:
                                                                const InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          14,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              border:
                                                                  OutlineInputBorder(),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 50),
                                                      ],
                                                    )
                                                  : Container(),
                                              const SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  const SizedBox(width: 25),
                                                  Container(
                                                    width: 250,
                                                    height: 2,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              0, 221, 220, 220),
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
                                                    fontWeight:
                                                        FontWeight.w700),
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
                                                    fontWeight:
                                                        FontWeight.w700),
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
                                              const SizedBox(width: 40),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ValueListenableBuilder(
                                    valueListenable: _isLoadingNotifier,
                                    builder: (context, _isLoading, _) {
                                      return ElevatedButton(
                                        child: const Text(' Create Order ',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                            )),
                                        onPressed: (_isLoading == true)
                                            ? null
                                            : () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  if (itemCount > 0) {
                                                    _isLoadingNotifier.value =
                                                        true;
                                                    OrderService(
                                                            firestore:
                                                                widget
                                                                    .firestore)
                                                        .addOrder(
                                                            chosenCustomer!.id,
                                                            chosenCustomer!
                                                                .firstName,
                                                            chosenCustomer!
                                                                .lastName,
                                                            _addressController
                                                                .text,
                                                            _contactController
                                                                .text,
                                                            _deliveryDateController!,
                                                            _isRushOrder,
                                                            _isDeliveryOrder,
                                                            _orderStatusController!,
                                                            int.tryParse(
                                                                _deliveryFee
                                                                    .text),
                                                            smallLechonItemCount,
                                                            mediumLechonItemCount,
                                                            largeLechonItemCount,
                                                            extraLargeLechonItemCount)
                                                        .then((value) {
                                                      debugPrint(
                                                          "Order Added successfully!");
                                                      Navigator.of(context)
                                                          .pop();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              generalSnackbar(
                                                                  'Order was added successfully!'));
                                                      _isLoadingNotifier.value =
                                                          false;
                                                    }).onError((error,
                                                            stackTrace) {
                                                      debugPrint(
                                                          "I did something bad... $error");
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              generalSnackbar(
                                                                  'Something went wrong. Order was not added.'));
                                                      _isLoadingNotifier.value =
                                                          false;
                                                    });

                                                    /*
                                              debugPrint(
                                                "CustomerID - ${chosenCustomer!.id}\n"
                                                "CustomerName - ${chosenCustomer!.firstName} ${chosenCustomer!.lastName}\n"
                                                "Address - ${_addressController.text}\n"
                                                "Contact - ${_contactController.text}\n"
                                                "DeliveryDate - ${_deliveryDateController.toString()}\n"
                                                "Rushed? ${_isRushOrder ? 'Yes' : 'No'}\n"
                                                "Delivery? ${_isDeliveryOrder ? 'Yes' : 'No'}\n"
                                                "DeliveryFee - ${_deliveryFee.text}\n"
                                                "Status - $_orderStatusController\n"
                                                "Method - $_orderPaymentMethodController\n"
                                                "Details - $smallLechonItemCount,$mediumLechonItemCount,$largeLechonItemCount,$extraLargeLechonItemCount\n"
                                              );
                                              */
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            generalSnackbar(
                                                                'A Lechon order is required.'));
                                                  }
                                                }
                                              },
                                        style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          primary: const Color(0xFFF1A22C),
                                          onPrimary: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                        ),
                                      );
                                    }),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ]),
                      ],
                    )
                  ]),
                ),
              ))),
    );
  }

  // small lechon
  Widget smallLechonWidget(int basePrice, String name) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Small Lechon",
                        style: GoogleFonts.mulish(
                          color: const Color.fromARGB(255, 71, 71, 71),
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
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFD3231E),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: const Color(0xFFD3231E)),
                          ),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(40, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                primary:
                                    const Color.fromARGB(255, 243, 243, 243),
                              ),
                              child: const Text(
                                "-",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFD3231E)),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (smallLechonItemCount > 0) {
                                    smallLechonItemCount--;
                                    smallLechonPrice -= basePrice;

                                    itemCount--;
                                    subTotal -= basePrice;
                                    totalFee -= basePrice;
                                  }
                                });
                              }),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          smallLechonItemCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: const Color(0xFFD3231E)),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(40, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              primary: const Color.fromARGB(255, 243, 243, 243),
                            ),
                            child: const Text(
                              "+",
                              key: Key("addSmallLechon"),
                              style: TextStyle(
                                  color: Color(0xFFD3231E),
                                  fontWeight: FontWeight.bold),
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
          ),
          // const SizedBox(
          //   width: 35,
          // ),
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
                        "Medium Lechon",
                        style: GoogleFonts.mulish(
                          color: const Color.fromARGB(255, 71, 71, 71),
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
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFD3231E),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: const Color(0xFFD3231E)),
                          ),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(40, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                primary:
                                    const Color.fromARGB(255, 243, 243, 243),
                              ),
                              child: const Text(
                                "-",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFD3231E)),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (mediumLechonItemCount > 0) {
                                    // !here
                                    mediumLechonItemCount--; // ! here
                                    mediumLechonPrice -= basePrice; // ! here

                                    itemCount--;
                                    subTotal -= basePrice;
                                    totalFee -= basePrice;
                                  }
                                });
                              }),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          mediumLechonItemCount.toString(), // ! here
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: const Color(0xFFD3231E)),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(40, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              primary: const Color.fromARGB(255, 243, 243, 243),
                            ),
                            child: const Text(
                              "+",
                              key: Key("addMediumLechon"),
                              style: TextStyle(
                                  color: Color(0xFFD3231E),
                                  fontWeight: FontWeight.bold),
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
              const SizedBox(
                width: 5,
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
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Large Lechon",
                        style: GoogleFonts.mulish(
                          color: const Color.fromARGB(255, 71, 71, 71),
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
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFD3231E),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: const Color(0xFFD3231E)),
                          ),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(40, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                primary:
                                    const Color.fromARGB(255, 243, 243, 243),
                              ),
                              child: const Text(
                                "-",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFD3231E)),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (largeLechonItemCount > 0) {
                                    // !here
                                    largeLechonItemCount--; // ! here
                                    largeLechonPrice -= basePrice; // ! here

                                    itemCount--;
                                    subTotal -= basePrice;
                                    totalFee -= basePrice;
                                  }
                                });
                              }),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          largeLechonItemCount.toString(), // ! here
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: const Color(0xFFD3231E)),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(40, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              primary: const Color.fromARGB(255, 243, 243, 243),
                            ),
                            child: const Text(
                              "+",
                              key: Key("addLargeLechon"),
                              style: TextStyle(
                                  color: Color(0xFFD3231E),
                                  fontWeight: FontWeight.bold),
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
              const SizedBox(
                width: 5,
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
                  const SizedBox(width: 38),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "XL Lechon",
                        style: GoogleFonts.mulish(
                          color: const Color.fromARGB(255, 71, 71, 71),
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
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFD3231E),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: const Color(0xFFD3231E)),
                          ),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(40, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                primary:
                                    const Color.fromARGB(255, 243, 243, 243),
                              ),
                              child: const Text(
                                "-",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFD3231E)),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (extraLargeLechonItemCount > 0) {
                                    // !here
                                    extraLargeLechonItemCount--; // ! here
                                    extraLargeLechonPrice -=
                                        basePrice; // ! here

                                    itemCount--;
                                    subTotal -= basePrice;
                                    totalFee -= basePrice;
                                  }
                                });
                              }),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          extraLargeLechonItemCount.toString(), // ! here
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: const Color(0xFFD3231E)),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(40, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              primary: const Color.fromARGB(255, 243, 243, 243),
                            ),
                            child: const Text(
                              "+",
                              key: Key("addXLLechon"),
                              style: TextStyle(
                                  color: Color(0xFFD3231E),
                                  fontWeight: FontWeight.bold),
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
              const SizedBox(
                width: 5,
              ),
            ],
          )
        ],
      ),
    );
  }

  // general order deets
  Widget orderInfoDeets() {
    return SizedBox(
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
                totalFee = (totalFee -
                    (_deliveryFee.text.isNotEmpty
                        ? double.parse(_deliveryFee.text)
                        : 0));
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
    );
  }

  // customer information widhet
  Widget customerOrderInfoDeets() {
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
            //height: 35,
            child: TypeAheadFormField(
              hideOnLoading: true,
              textFieldConfiguration: TextFieldConfiguration(
                controller: _searchCustomerController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.person_search_outlined),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                ),
              ),

              suggestionsCallback: (pattern) async {
                return CustomerService(firestore: widget.firestore)
                    .getSuggestion(pattern);
              },

              // frontend edit inside here if u want to edit the box itself
              suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                  constraints: BoxConstraints(maxHeight: 200.0)),

              itemBuilder: (context, Customer customer) {
                return ListTile(
                  title: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      WidgetSpan(
                          child: Container(
                              padding: const EdgeInsets.only(right: 2.5),
                              child: Icon(Icons.person_sharp,
                                  size: 14.0, color: customer.tagColor))),
                      TextSpan(
                        text: '${customer.firstName} ${customer.lastName}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black87,
                            //fontSize: 14.0,
                            fontWeight: FontWeight.w300),
                      )
                    ]),
                  ),
                  subtitle: '${customer.adrBarangay}${customer.adrCity}' != ''
                      ? Text(
                          '${customer.adrBarangay}${customer.adrBarangay == '' ? '' : ' '}${customer.adrCity}',
                          overflow: TextOverflow.ellipsis,
                        )
                      : Text(
                          '[Not Available]',
                          style: TextStyle(color: Colors.red.shade200),
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
                _searchCustomerController.text =
                    '${customer.firstName} ${customer.lastName}';
                _addressController.text = (customer.adrStreet.isNotEmpty
                        ? '${customer.adrStreet} '
                        : '') +
                    (customer.adrBarangay.isNotEmpty
                        ? '${customer.adrBarangay} '
                        : '') +
                    (customer.adrCity.isNotEmpty
                        ? '${customer.adrCity} '
                        : '') +
                    (customer.adrProvince.isNotEmpty
                        ? '${customer.adrProvince} '
                        : '') +
                    (customer.adrZipcode.isNotEmpty
                        ? '${customer.adrZipcode} '
                        : '');
                _contactController.text = customer.celNum;
              },

              noItemsFoundBuilder: (context) {
                return ListTile(
                  title: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      WidgetSpan(
                          child: Container(
                              padding: const EdgeInsets.only(right: 2.5),
                              child: const Icon(Icons.person_add_alt,
                                  size: 14.0))),
                      const TextSpan(
                        text: 'This customer does not exist.',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black87,
                            fontWeight: FontWeight.w300),
                      )
                    ]),
                  ),
                  subtitle: const Text(
                    'Add this customer into the system!',
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCustomer(
                                  firestore: widget.firestore,
                                )));
                  },
                );
              },

              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please select a customer.';
                }
                if (chosenCustomer == null) {
                  return 'This customer is not in the database. Try again.';
                }
                return null;
              },
            )),
        const SizedBox(height: 10),
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
          //height: 35,
          child: TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // labelText: 'Name',
                contentPadding: EdgeInsets.symmetric(horizontal: 15)),
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().isEmpty) {
                return "Please input an address";
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 10),
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
          //height: 35,
          child: TextFormField(
            controller: _contactController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // labelText: 'Name',
                contentPadding: EdgeInsets.symmetric(horizontal: 15)),
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().isEmpty) {
                return "Please input contact details";
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Status',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.grey,
              fontSize: 12.0,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(
          width: 350,
          // height: 35,
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              //isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              border: OutlineInputBorder(),
            ),
            items: paymentStatus.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                _orderStatusController = val;
              });
            },
            validator: (val) {
              if (val == null) {
                return 'Please provide order status';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Delivery Date & Time:',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.grey,
              fontSize: 12.0,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(
            width: 350,
            //height: 35,
            child: DateTimeField(
              format: format,
              onChanged: (val) {
                setState(() {
                  _deliveryDateController = val;
                });
              },
              validator: (val) {
                if (val == null) {
                  return 'Please provide deivery date/time';
                }
                return null;
              },
              decoration: const InputDecoration(
                //isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                border: OutlineInputBorder(),
              ),
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    initialEntryMode: DatePickerEntryMode.input);
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue;
                }
              },
            )),
        const SizedBox(height: 10),
        orderInfoDeets()
      ],
    );
  }
}
