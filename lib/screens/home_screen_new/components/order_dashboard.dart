import 'package:dennis_lechon_crm/screens/homebuttons/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDash extends StatelessWidget {
  const OrderDash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            CustomerCard(
                date: "May 22, 2022",
                orderNo: 'Order #1231',
                name: 'Melzar Chico',
                address: 'Lapu-Lapu City',
                orders: 'Whole Lechon (Small) 2x',
                price: 10000,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderListScreen()),
                  );
                }),
            CustomerCard(
                date: "December 14, 2022",
                orderNo: 'Order #69678',
                name: 'Emma Axe',
                address: 'Tungkil, Minglanilla',
                orders: 'Whole Lechon (Large) 3x',
                price: 50000,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderListScreen()),
                  );
                }),
            CustomerCard(
                date: "May 29, 2022",
                orderNo: 'Order #5678',
                name: 'Dianne Mondido Leonora Tiabela Mona Lisa Cheche Bureche',
                address: 'Tungkop, Minglanilla',
                orders: 'Whole Lechon (Medium) 2x\nWhole Lechon (Large) 1x',
                price: 12000,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderListScreen()),
                  );
                }),
          ],
        ));
  }
}

class CustomerCard extends StatelessWidget {
  const CustomerCard(
      {Key? key,
      required this.date,
      required this.orderNo,
      required this.name,
      required this.address,
      required this.orders,
      required this.press,
      required this.price})
      : super(key: key);

  final String orderNo, name, address, date, orders;
  final int price;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(
          left: 20,
          top: 0,
          bottom: 30,
        ),
        width: size.width * 0.60,
        //height: 100,
        //size.width * 0.4,
        child: Column(
          children: <Widget>[
            // Container(
            //   decoration: const BoxDecoration(
            //       color: Color(0xFFD3231E),
            //       borderRadius: BorderRadius.only(
            //           topRight: Radius.circular(10),
            //           topLeft: Radius.circular(10))),
            //   height: 32,
            //   width: size.width * 0.60,
            //   child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Text(orderNo,
            //             style: GoogleFonts.baloo2(
            //                 fontSize: 13,
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.bold)),
            //       ]),
            // ),
            GestureDetector(
              onTap: press,
              child: Container(
                //color: Colors.red,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 15),
                      blurRadius: 15,
                      color: Color.fromARGB(62, 158, 158, 158),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "$orderNo\n",
                                  style: GoogleFonts.baloo2(
                                      //fontFamily: 'Baloo_2',
                                      fontSize: 13,
                                      color: const Color(0xFF1F2426),
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "$name\n",
                                  style: GoogleFonts.baloo2(
                                      //fontFamily: 'Baloo_2',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF1F2426))),
                              TextSpan(
                                text: "$address\n\n",
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF7D8EA3),
                                ),
                              ),
                              TextSpan(
                                text: orders,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF1F2426),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: "       Php\n",
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                  color: Color(0xFF1F2426))),
                          TextSpan(
                            text: "$price",
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFF1A22C),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // child: Row(
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: <Widget>[
                //         Text(
                //           name,
                //           style: GoogleFonts.baloo2(
                //             fontSize: 20,
                //             fontWeight: FontWeight.w800,
                //             color: const Color(0xFF1F2426),
                //           ),
                //         ),
                //         Text(
                //           address,
                //           style: const TextStyle(
                //             color: Color(0xFF7D8EA3),
                //           ),
                //         ),
                //         const SizedBox(height: 10),
                //         Text(
                //           date,
                //           style: const TextStyle(
                //             color: Color(0xFF1F2426),
                //           ),
                //         ),
                //         SizedBox(width: size.width * 0.50),
                //       ],
                //     ),
                //     const Text(
                //       "Php",
                //       style: TextStyle(
                //         color: Color(0xFF1F2426),
                //       ),
                //     ),
                //     Text(
                //       "$price",
                //       style: const TextStyle(
                //         color: Color(0xFF1F2426),
                //       ),
                //     )
                //   ],
                // ),
              ),
            ),
          ],
        ));
  }
}
