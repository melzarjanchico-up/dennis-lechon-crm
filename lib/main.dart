//import 'package:dennis_lechon_crm/screens/homebuttons/customer_screen.dart';
//import 'package:dennis_lechon_crm/screens/login_screens/home_screen.dart';
//import 'package:dennis_lechon_crm/screens/homebuttons/customer_screen.dart';
import 'package:dennis_lechon_crm/screens/login_screens/signin_screen.dart'; // temporary for testing
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_info.dart';

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
    return const MaterialApp(
      title: 'Project LechGo',
      debugShowCheckedModeBanner: false,
      home: SignIn(),
      //home: CustomerScreen(),
    );
  }
}
