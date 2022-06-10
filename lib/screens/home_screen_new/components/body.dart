import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/screens/home_screen_new/components/customer_dashboard.dart';
import 'package:dennis_lechon_crm/screens/home_screen_new/components/order_dashboard.dart';
import 'package:dennis_lechon_crm/screens/home_screen_new/components/calendar_dashboard.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/customer_screen.dart';
// import 'package:dennis_lechon_crm/screens/homebuttons/order_screen.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/calendar_screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.firestore}) : super(key: key);
  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              height: size.height * 0.15,
              child: Stack(children: <Widget>[
                Container(
                  height: 60,
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: Color(0xFFD3231E),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      //SizedBox(width: 10),
                      // Text('Lech Go!',
                      //     style: TextStyle(
                      //         fontSize: 22,
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(30, 10, 30, 15),
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        0,
                        10,
                        0,
                      ),
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 10,
                              color: Color.fromARGB(75, 202, 201, 201),
                            ),
                          ]),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: TextField(
                          onChanged: (value) {},
                          decoration: const InputDecoration(
                            hintText: "Search Customer",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF1F2426),
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        )),
                        const Icon(Icons.search, color: Color(0xFF1F2426)),
                      ])),
                ),
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Your Customers",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFF1A22C),
                    onPrimary: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: const EdgeInsets.all(15.0),
                    minimumSize: const Size(4, 3),
                  ),
                  child: Row(
                    children: const [
                      Text(
                        "See list",
                        style: TextStyle(
                          fontFamily: 'Oxygen',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_double_arrow_right_rounded,
                        key: Key("Customer Button"),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => CustomerScreen(
                                  firestore: firestore,
                                ))));
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            const CustomerDash(
                //firestore: firestore,
                ),
            const SizedBox(height: 15),
            Row(
              children: const [
                Text("   Incoming Orders",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
                SizedBox(width: 40),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     primary: const Color(0xFFD3231E),
                //     onPrimary: Colors.white,
                //     elevation: 5,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(50.0),
                //     ),
                //     padding: const EdgeInsets.all(15.0),
                //     minimumSize: const Size(4, 3),
                //   ),
                //   child: Row(
                //     children: const [
                //       Text(
                //         "",
                //         style: TextStyle(
                //           fontFamily: 'Oxygen',
                //           fontSize: 15,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       Icon(Icons.keyboard_double_arrow_right_rounded),
                //     ],
                //   ),
                //   onPressed: () async {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: ((context) => OrderListScreen(
                //                   firestore: firestore,
                //                   // order: order,
                //                 ))));
                //   },
                // ),
              ],
            ),
            const SizedBox(height: 10),
            OrderDash(
              firestore: firestore,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Your Calendar",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF2A87BB),
                    onPrimary: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: const EdgeInsets.all(15.0),
                    minimumSize: const Size(4, 3),
                  ),
                  child: Row(
                    children: const [
                      Text(
                        "",
                        style: TextStyle(
                          fontFamily: 'Oxygen',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.keyboard_double_arrow_right_rounded),
                    ],
                  ),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => CalendarScreen(
                                  firestore: firestore,
                                ))));
                  },
                ),
              ],
            ),
            //const SizedBox(height: 10),
            //const Text("     May 2022",
            //    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
            //const SizedBox(height: 20),
            CalendarDash(firestore: firestore,),
          ]),
    );
  }
}
