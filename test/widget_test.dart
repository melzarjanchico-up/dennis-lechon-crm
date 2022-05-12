// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

//import 'package:flutter/material.dart';
//import 'package:dennis_lechon_crm/models/customer.dart';
//import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/customer_list.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/calendar_screen.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/customer_screen.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/order_screen.dart';
import 'package:dennis_lechon_crm/screens/login_screens/home_screen.dart';
import 'package:dennis_lechon_crm/screens/login_screens/resetpassword_screen.dart';
import 'package:dennis_lechon_crm/screens/login_screens/signin_screen.dart';
import 'package:dennis_lechon_crm/screens/login_screens/signup_screen.dart';
//import 'package:dennis_lechon_crm/services/customer_database_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dennis_lechon_crm/main.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'mock.dart';

void main() {
  //This is for creating a Mock for Firebase.initialize
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets('Project LechGo is successful', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
  });

  testWidgets('Main smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
  });

  testWidgets('Sign In smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignIn()));
    await tester.pumpAndSettle();
  });

  testWidgets('Sign Up smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: SignUp()));
    await tester.pumpAndSettle();
  });

  testWidgets('Reset Password smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: ResetPassword()));
    await tester.pumpAndSettle();
  });

  testWidgets('Home Screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    await tester.pumpAndSettle();
  });

  testWidgets('Customer Screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CustomerScreen());
  });

  // testWidgets('Customer List Screen smoke test', (WidgetTester tester) async {
  //   StreamController<List<Customer>> customer = StreamController<List<Customer>>();
  //   await tester.pumpWidget(StreamBuilder<List<Customer>>(

  //     stream: CustomerService().customers,
  //     builder: (context, snapshot) {},
  //   );
  //   await refresh();
  // });

  testWidgets('Order Screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const OrderListScreen());
  });

  testWidgets('Calendar Screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CalendarScreen());
    await tester.pumpAndSettle();
  });
}
