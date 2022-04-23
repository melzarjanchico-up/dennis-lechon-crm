//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_info/button_widget.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_info/customer_picture.dart';

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
        title: Text('${widget.customer.firstName}\'s Information'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 15), // for Info Space
          buildInfo(widget.customer),
          const SizedBox(height: 15), // for Notes Space
          Center(child: buildNotes(widget.customer)),
          Column(children: const <Widget>[
            SizedBox(height: 10),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            const SizedBox(height: 25, width: 15), // for Edit Profile Button
            Center(child: buildEditProfileButton()),
            const SizedBox(height: 25, width: 15), // for Order List Button
            Center(child: buildOrderListButton()),
          ])
        ],
      ),
    );
  }
}

String convertDateToText(DateTime givenDate) {
  var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${months[(givenDate.month)-1]}. ${givenDate.day.toString().padLeft(2, '0')}, ${givenDate.year}';
}

int calculateAge(DateTime birthDate) {
  var from = birthDate;
  var to = DateTime.now();
  return ((to.difference(from).inHours / 24) / 365).round();
}

Widget buildInfo(Customer customer) {

  String middleInitial = (customer.middleName != '') ? '${(customer.middleName[0])}.' : '';
  String space = (middleInitial == '') ? '' : ' ';

  return Column(
    children: [
      Card(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${customer.firstName} $middleInitial$space${customer.lastName}',
                        style: const TextStyle(
                            fontSize: 17.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(height: 10),
                      (customer.celNum != '')
                          ? const Text(
                              'Cellphone No.',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w300),
                            )
                          : const SizedBox(width: 0, height: 0),
                      (customer.celNum != '')
                          ? Text(
                              customer.celNum,
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                  height: 1,
                                  fontWeight: FontWeight.w300),
                            )
                          : const SizedBox(height: 5),
                      (customer.telNum != '')
                          ? const Text(
                              'Telephone No.',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w300),
                            )
                          : const SizedBox(width: 0, height: 0),
                      (customer.telNum != '')
                          ? Text(
                              customer.telNum,
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.w300),
                            )
                          : const SizedBox(height: 5),
                      const Text(
                        'Address',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        '${customer.adrBarangay}, ${customer.adrCity} ${customer.adrZipcode}',
                        style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Age',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        '${calculateAge(customer.dateBirth).toString()} yrs. old',
                        style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Birthday",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        convertDateToText(customer.dateBirth),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Date Added",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        convertDateToText(customer.dateAdded),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Tag",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w300),
                      ),
                      //Text(
                      //  customer.tagName.toUpperCase(),
                      //  style: TextStyle(
                      //      color: customer.tagColor,
                      //      fontSize: 16.0,
                      //      fontWeight: FontWeight.w600),
                      //),
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: customer.tagColor),
                        child: Text(
                          customer.tagName,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  ProfileWidget(
                    imagePath: 'assets/images/user.png',
                    onClicked: () async {},
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
      /*
      Card(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  children: const [
                    Text(
                      "Birthday",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "TEST BIRTHDAY",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: const [
                    Text(
                      "Last Ordered",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "n/a",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "Tag",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      customer.tagName.toUpperCase(),
                      style: TextStyle(
                          color: Color(int.parse(
                              (customer.tagColor).split('(0x')[1].split(')')[0],
                              radix: 16)),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    */
    ],
  );
}

Widget buildOrderListButton() => ElevatedButton(
      child: const Text(' ORDER LIST '),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        primary: const Color(0xFFD3231E),
        onPrimary: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
      ),
    );

Widget buildEditProfileButton() => ButtonWidget(
      text: 'EDIT PROFILE',
      onClicked: () {},
    );

Widget buildNotes(Customer customer) => Card(
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            // gi ontap para sa future na edit notes :)
            debugPrint('Card tapped.');
          },
          child: Container(
              width: 350,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.white,
              ),
              child: Stack(children: [
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 35,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1A22C),
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: const Text('NOTES',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0),
                  child: Text(customer.note),
                ))
              ]))),
    );
