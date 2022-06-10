//import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_info/edit_customer_new.dart';
import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_info/button_widget.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:dennis_lechon_crm/screens/customer_screen/customer_info/customer_picture.dart';
//import 'package:random_avatar/random_avatar.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_info/customer_orderlist.dart';

String getDateFromDate(DateTime givenDate) {
  var months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  String datePart =
      '${months[(givenDate.month) - 1]} ${givenDate.day.toString().padLeft(2, '0')}, ${givenDate.year}';
  return datePart;
}

String getTimeFromDate(DateTime givenDate) {
  String timePart =
      '${givenDate.hour.toString().padLeft(2, '0')}:${givenDate.minute.toString().padLeft(2, '0')}';
  return timePart;
}

int calculateAge(DateTime birthDate) {
  var from = birthDate;
  var to = DateTime.now();
  return ((to.difference(from).inHours / 24) / 365).floor();
}

class CustomerInfo extends StatefulWidget {
  const CustomerInfo(
      {Key? key, required this.customer, required this.firestore})
      : super(key: key);
  final Customer customer;
  final FirebaseFirestore firestore;

  @override
  State<CustomerInfo> createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("Customer Information"),
      appBar: AppBar(
        backgroundColor: widget.customer.tagColor,
        title: Text(
          '${widget.customer.firstName}\'s Information',
          style: GoogleFonts.oxygen(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 10),
        physics: const BouncingScrollPhysics(),
        children: [
          buildInfo(widget.customer),
          Center(child: buildNotes(widget.customer, context)),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: buildEditProfileButton(
                          context, widget.customer, widget.firestore)),
                  const SizedBox(
                      height: 25, width: 15), // for Order List Button
                  Center(
                      child: buildOrderListButton(
                          context, widget.customer, widget.firestore)),
                ]),
          )
        ],
      ),
    );
  }
}

Widget buildInfo(Customer customer) {
  String middleInitial =
      (customer.middleName != '') ? '${(customer.middleName[0])}. ' : '';
  String address =
      (customer.adrStreet.isNotEmpty ? '${customer.adrStreet} ' : '') +
          (customer.adrBarangay.isNotEmpty ? '${customer.adrBarangay} ' : '') +
          (customer.adrCity.isNotEmpty ? '${customer.adrCity} ' : '') +
          (customer.adrProvince.isNotEmpty ? '${customer.adrProvince} ' : '') +
          (customer.adrZipcode.isNotEmpty ? '${customer.adrZipcode} ' : '');

  return Column(
    children: [
      Card(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 20, 30),
          child: Column(
            children: [
              Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Text(
                              '${customer.firstName} $middleInitial${customer.lastName}',
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF1F2426),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),

                          // cellphone number
                          (customer.celNum != '')
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Cellphone No.',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          customer.celNum,
                                          style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 15,
                                          ),
                                        ),
                                      ]),
                                )
                              : const SizedBox(),

                          // telephone number
                          (customer.telNum != '')
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Telephone No.',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        customer.telNum,
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF1F2426),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),

                          // address
                          (address != '')
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Address',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        address,
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF1F2426),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),

                          // age
                          (customer.dateBirth != null)
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Age',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        (customer.dateBirth != null)
                                            ? '${calculateAge(customer.dateBirth!)} years old'
                                            : "No Age",
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF1F2426),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),

                          // birthday
                          (customer.dateBirth != null)
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Birthday",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        (customer.dateBirth != null)
                                            ? getDateFromDate(
                                                customer.dateBirth!)
                                            : "No Birth Date",
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF1F2426),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),

                          // date added
                          (customer.dateAdded != null)
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Date Added",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        (customer.dateAdded != null)
                                            ? '${getDateFromDate(customer.dateAdded!)}, ${getTimeFromDate(customer.dateAdded!)}'
                                            : "No Added Date",
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF1F2426),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),

                          // tag
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Tag",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 2),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: customer.tagColor),
                                  child: Text(
                                    customer.tagName,
                                    style: const TextStyle(
                                      fontFamily: 'Oxygen',
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
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
                  // Container(
                  //   margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(50),
                  //       color: customer.tagColor),
                  //   height: 180,
                  //   width: 150,
                  //   child: randomAvatar(
                  //     customer.firstName,
                  //     trBackground: true,
                  //     fit: BoxFit.fitWidth,
                  //   ),
                  // ),
                  // Expanded(
                  //   flex: 4,
                  //   // child: Avatar(
                  //   //     name: customer.firstName,
                  //   //     textStyle:
                  //   //         const TextStyle(fontSize: 60, color: Colors.white),
                  //   //     shape: AvatarShape.rectangle(250, 280,
                  //   //         const BorderRadius.all(Radius.circular(50.0)))),
                  //   // ProfileWidget(
                  //   //   customer: customer,
                  //   //   imagePath: 'assets/images/sampleUser.png',
                  //   //   onClicked: () async {},
                  //   // ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
    ],
  );
}

Widget buildOrderListButton(
        BuildContext context, Customer customer, FirebaseFirestore firestore) =>
    ElevatedButton(
      key: const Key("Order List Button"),
      child: const Text(' Order List ',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
          )),
      onPressed: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => CustomerOrderList(
                      customer: customer,
                      firestore: firestore,
                    ))));
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        primary: const Color(0xFFD3231E),
        onPrimary: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
      ),
    );

Widget buildEditProfileButton(
        BuildContext context, Customer customer, FirebaseFirestore firestore) =>
    ElevatedButton(
      key: const Key("Edit Profile Button"),
      child: const Text(' Edit Profile ',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
          )),
      onPressed: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => EditCustomer(
                      customer: customer,
                      firestore: firestore,
                    ))));
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        primary: Colors.blue.withAlpha(30),
        onPrimary: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
      ),
    );

Widget buildNotes(Customer customer, BuildContext context) => Card(
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            // gi ontap para sa future na edit notes :)
            debugPrint('Card tapped.');
          },
          child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.35),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.white,
              ),
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                      height: 35,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1A22C),
                        borderRadius: BorderRadius.circular(36),
                      ),
                      child: const Text('NOTES',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 60.0, 30.0, 30.0),
                  child: Text(
                    customer.note,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF1F2426),
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                )
              ]))),
    );
