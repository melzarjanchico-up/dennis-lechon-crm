import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/calendar_screen.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/customer_screen.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/orderlist_screen.dart';
import 'package:dennis_lechon_crm/screens/login_screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      //setState(() {
                      //  loading = true;
                      //});
                      //await Future.delayed(const Duration(seconds: 1));
                      //setState(() {
                      //  loading = false;
                      //});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CustomerScreen()));
                    },
                    icon: const Icon(Icons.person),
                    label: Text(
                      "Customer List",
                      style: GoogleFonts.oxygen(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFF1A22C),
                      onPrimary: Colors.white,
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0)),
                      minimumSize: const Size(230, 90),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await Future.delayed(const Duration(seconds: 1));
                      setState(() {
                        loading = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrderListScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFD3231E),
                      onPrimary: Colors.white,
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0)),
                      minimumSize: const Size(230, 90),
                    ),
                    icon: const Icon(Icons.list),
                    label: Text(
                      "Order List",
                      style: GoogleFonts.oxygen(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await Future.delayed(const Duration(seconds: 1));
                      setState(() {
                        loading = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CalendarScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF2A87BB),
                      onPrimary: Colors.white,
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0)),
                      minimumSize: const Size(230, 90),
                    ),
                    icon: const Icon(Icons.calendar_month),
                    label: Text(
                      "Calendar",
                      style: GoogleFonts.oxygen(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: const Text("Logout"),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await Future.delayed(const Duration(seconds: 1));
                      setState(() {
                        loading = false;
                      });
                      FirebaseAuth.instance.signOut().then((value) {
                        debugPrint("Signed Out");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn()));
                      });
                    },
                  ),
                ],
              ),
              //body: Center(
              //child:
            ),
          );
  }
}
