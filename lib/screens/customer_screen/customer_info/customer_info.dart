//import 'package:flutter/foundation.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_info/edit_customer_new.dart';
import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_info/button_widget.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_info/customer_picture.dart';
import 'package:google_fonts/google_fonts.dart';

String getDateFromDate(DateTime givenDate) {
  var months = ['Jan','Feb','Mar','Apr','May','June','Jul','Aug','Sep','Oct','Nov','Dec'];
  String datePart = '${months[(givenDate.month) - 1]}. ${givenDate.day.toString().padLeft(2, '0')}, ${givenDate.year}';
  return datePart;
}

String getTimeFromDate(DateTime givenDate) {
  String timePart = '${givenDate.hour.toString().padLeft(2, '0')}:${givenDate.minute.toString().padLeft(2, '0')}';
  return timePart;
}

int calculateAge(DateTime birthDate) {
  var from = birthDate;
  var to = DateTime.now();
  return ((to.difference(from).inHours / 24) / 365).floor();
}

class CustomerInfo extends StatefulWidget {
  const CustomerInfo({Key? key, required this.customer}) : super(key: key);
  final Customer customer;

  @override
  State<CustomerInfo> createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.customer.tagColor,
        title: Text('${widget.customer.firstName}\'s Information',
            style: GoogleFonts.oxygen(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            )),
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
                  Center(child: buildEditProfileButton(context, widget.customer)),
                  const SizedBox(
                      height: 25, width: 15), // for Order List Button
                  Center(child: buildOrderListButton()),
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

  return Column(
    children: [
      Card(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 20, 30),
          child: Column(
            children: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Text(
                            '${customer.firstName} $middleInitial${customer.lastName}',
                            style: GoogleFonts.montserrat(
                              color: const Color(0xFF1F2426),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
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
                                      Text(
                                        'Cellphone No.',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        customer.celNum,
                                        style: GoogleFonts.montserrat(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Telephone No.',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      customer.telNum,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF1F2426),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
  
                        // address
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Address',
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '${customer.adrBarangay} ${customer.adrCity} ${customer.adrZipcode}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1F2426),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // age
                        (customer.dateBirth != null) ?
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Age',
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                (customer.dateBirth != null) ?
                                  '${calculateAge(customer.dateBirth!)} years old' : "No Age",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1F2426),
                                ),
                              ),
                            ],
                          ),
                        ) : const SizedBox(),

                        // birthday
                        (customer.dateBirth != null) ?
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Birthday",
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                (customer.dateBirth != null) ?
                                  getDateFromDate(customer.dateBirth!) : "No Birth Date",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1F2426),
                                ),
                              ),
                            ],
                          ),
                        ) : const SizedBox(),

                        // date added
                        (customer.dateAdded != null) ?
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date Added",
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                (customer.dateAdded != null) ? 
                                  '${getDateFromDate(customer.dateAdded!)}, ${getTimeFromDate(customer.dateAdded!)}' : "No Added Date",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1F2426),
                                ),
                              ),
                            ],
                          ),
                        ) : const SizedBox(),

                        // tag
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tag",
                                style: GoogleFonts.montserrat(
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
                                  style: GoogleFonts.mulish(
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
                  
                  Expanded(
                    flex: 4,
                    child: ProfileWidget(
                      customer: customer,
                      imagePath: 'assets/images/sampleUser.png',
                      onClicked: () async {},
                    ),
                  ),
                  
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

Widget buildOrderListButton() => ElevatedButton(
      child: Text(' Order List ',
          style: GoogleFonts.montserrat(
            color: Colors.white,
          )),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        primary: const Color(0xFFD3231E),
        onPrimary: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
      ),
    );

Widget buildEditProfileButton(BuildContext context, Customer customer) => ButtonWidget(
      text: 'Edit Profile',
      onClicked: () async {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: ((context) => EditCustomer(
            customer: customer,
          )))
        );
      },
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
                      child: Text('NOTES',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 60.0, 30.0, 30.0),
                  child: Text(
                    customer.note,
                    style: GoogleFonts.montserrat(
                      color: const Color(0xFF1F2426),
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                )
              ]))),
    );
