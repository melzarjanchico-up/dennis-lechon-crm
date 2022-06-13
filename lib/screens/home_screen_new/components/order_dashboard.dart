import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/models/order.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/order_screen.dart';
import 'package:dennis_lechon_crm/services/order_database_services.dart';
import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDash extends StatelessWidget {
  const OrderDash({Key? key, required this.firestore}) : super(key: key);
  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CustomerCard(
            firestore: firestore,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderListScreen(
                          firestore: firestore,
                        )),
              );
            }),
      ],
    );
  }
}

class CustomerCard extends StatelessWidget {
  const CustomerCard(
      {Key? key,
      //required this.orderNo,
      required this.press,
      required this.firestore})
      : super(key: key);

  //final String orderNo;
  final VoidCallback press;
  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(
          left: 25,
          right: 20,
          top: 5,
          bottom: 15,
        ),
        width: size.width * 0.87,
        //height: 100,
        //size.width * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10, left: 0),
              //color: Colors.red,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFD3231E), Color.fromARGB(255, 253, 82, 30)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 15),
                    blurRadius: 15,
                    color: Color.fromARGB(62, 158, 158, 158),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(width: 15),
                      const CircleAvatar(
                        backgroundColor: Color.fromARGB(148, 172, 21, 15),
                        radius: 30,
                        child: Icon(Icons.food_bank_rounded,
                            size: 30, color: Colors.white),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: StreamBuilder<List<Order>>(
                            stream: OrderService(firestore: firestore).orders,
                            builder: (context, snapshot) {
                              // will add error here later
                              if (snapshot.hasData) {
                                debugPrint(snapshot.data!.length.toString());
                                return RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text:
                                              snapshot.data!.length.toString() +
                                                  ' ',
                                          style: GoogleFonts.baloo2(
                                              //fontFamily: 'Baloo_2',
                                              fontSize: 30,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: " orders",
                                          style: GoogleFonts.baloo2(
                                              //fontFamily: 'Baloo_2',
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white)),
                                    ],
                                  ),
                                );
                              }
                              return const ClearLoading();
                            }),
                      ),
                      const SizedBox(width: 20),
                      //Icon(Icons.keyboard_double_arrow_right_rounded),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: const Color(0xFFD3231E),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          padding: const EdgeInsets.all(15.0),
                          minimumSize: const Size(10, 9),
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
                        onPressed: press,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ));
  }
}
