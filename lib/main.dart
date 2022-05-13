//import 'package:dennis_lechon_crm/screens/homebuttons/customer_screen.dart';
//import 'package:dennis_lechon_crm/screens/login_screens/home_screen.dart';
//import 'package:dennis_lechon_crm/screens/order_screen/order_list/add_order.dart';
//import 'package:dennis_lechon_crm/screens/homebuttons/customer_screen.dart';
//import 'package:dennis_lechon_crm/screens/login_screens/signin_screen.dart'; // temporary for testing
import 'package:firebase_core/firebase_core.dart';
// import 'package:dennis_lechon_crm/screens/homebuttons/order_screen.dart';
import 'package:flutter/material.dart';
//import 'package:dennis_lechon_crm/screens/customer_screen/customer_info.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:dennis_lechon_crm/screens/home_screen_new/dashboard.dart';

// atleast edit para mapush

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB9yv4QSumR3MiPX4xfk03GU04McRgdk2o", // Your apiKey
      appId: "1:482691784655:web:f48df984a82bddcc6ebcba", // Your appId
      messagingSenderId: "482691784655", // Your messagingSenderId
      projectId: "dennis-lechon-crm", // Your projectId
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project LechGo',
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      debugShowCheckedModeBanner: false,
      //home: SignIn(),
      home: const Dashboard(),
    );
  }
}
