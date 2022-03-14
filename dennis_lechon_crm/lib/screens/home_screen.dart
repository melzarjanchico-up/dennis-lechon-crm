import 'package:dennis_lechon_crm/screens/homebuttons/calendar_screen.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/customer_screen.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/orderList_screen.dart';
import 'package:dennis_lechon_crm/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CustomerScreen()));
              },
              icon: Icon(Icons.person),
              label: Text(
                "Customer List",
                style: GoogleFonts.oxygen(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFF1A22C),
                onPrimary: Colors.white,
                elevation: 12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0)),
                minimumSize: Size(230, 90),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderListScreen()));
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFD3231E),
                onPrimary: Colors.white,
                elevation: 12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0)),
                minimumSize: Size(230, 90),
              ),
              icon: Icon(Icons.list),
              label: Text(
                "Order List",
                style: GoogleFonts.oxygen(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CalendarScreen()));
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF2A87BB),
                onPrimary: Colors.white,
                elevation: 12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0)),
                minimumSize: Size(230, 90),
              ),
              icon: Icon(Icons.calendar_month),
              label: Text(
                "Calendar",
                style: GoogleFonts.oxygen(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              child: Text("Logout"),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("Signed Out");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignIn()));
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
