// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: unused_import

//import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:dennis_lechon_crm/models/order.dart';
//import 'package:dennis_lechon_crm/widgets/loading.dart';
//import 'package:dennis_lechon_crm/screens/customer_screen/customer_info/customer_info.dart';
//import 'package:mockito/mockito.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/customer_list.dart';
import 'package:dennis_lechon_crm/screens/home_screen_new/dashboard.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/calendar_screen.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/customer_screen.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/order_screen.dart';
import 'package:dennis_lechon_crm/screens/login_screens/resetpassword_screen.dart';
import 'package:dennis_lechon_crm/screens/login_screens/signin_screen.dart';
import 'package:dennis_lechon_crm/screens/login_screens/signup_screen.dart';
import 'package:dennis_lechon_crm/screens/order_screen/order_list/order_list.dart';
import 'package:dennis_lechon_crm/services/customer_database_services.dart';
import 'package:dennis_lechon_crm/services/order_database_services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dennis_lechon_crm/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';
import '../mock.dart';

void main() {
  //This is for creating a Mock for Firebase.initialize
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  // testWidgets('Project LechGo Main Test Widget', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());
  //   await tester.pumpAndSettle();
  // });

  testWidgets('Sign In smoke Test Widget', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignIn()));
    expect(find.byKey(const Key("Sign In")), findsWidgets);

    //Tests the  email textfield
    await tester.enterText(
        find.byKey(const Key("Email Key")), 'test123@gmail.com');
    await tester.pump();
    expect(find.text("test123@gmail.com"), findsOneWidget);

    //Tests the password button
    await tester.enterText(find.byKey(const Key("Pass Key")), 'test12345');
    await tester.pump();
    expect(find.text("test12345"), findsOneWidget);

    //Tests the Sign In button
    await tester.tap(find.text("LOG IN"));
    await tester.pump();
    expect(find.byKey(const Key("SignIn Key")), findsOneWidget);

    //Tests the SignUp Text Button
    await tester.tap(find.byKey(const Key("Sign Up Clickable")));
    await tester.pump();
    expect(find.byType(Scaffold), findsOneWidget); //Wrong way to do tests
  });

  testWidgets('Sign Up Test Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: SignUp()));
    expect(find.byKey(const Key("Sign Up")), findsOneWidget);

    //Tests the  username textfield
    await tester.enterText(find.byKey(const Key("Username Key")), 'test123');
    await tester.pump();
    expect(find.text("test123"), findsOneWidget);

    //Tests the  email textfield
    await tester.enterText(
        find.byKey(const Key("EmailFromSignUp Key")), 'test123@gmail.com');
    await tester.pump();
    expect(find.text("test123@gmail.com"), findsOneWidget);

    //Tests the password button
    await tester.enterText(
        find.byKey(const Key("PassFromSignUp Key")), 'test12345');
    await tester.pump();
    expect(find.text("test12345"), findsOneWidget);

    //Tests the Sign Up button
    await tester.tap(find.text("Sign Up"));
    await tester.pump();
    expect(find.byKey(const Key("SignUp Key")), findsOneWidget);
  });

  testWidgets('Reset Password Test Widgets', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: ResetPassword()));
    expect(find.byKey(const Key("Password Key")), findsWidgets);

    //Tests the  email textfield
    await tester.enterText(find.byType(TextField), 'test123@gmail.com');
    await tester.pump();
    expect(find.byKey(const Key("PassFromResetPass Key")), findsOneWidget);

    //Tests the ResetPassword button
    await tester.tap(find.text("Reset Password"));
    await tester.pump();
    expect(find.byKey(const Key("ResetPassword Key")), findsOneWidget);
  });

  // testWidgets('Dashboard Test Widgets', (WidgetTester tester) async {
  //   await tester.pumpWidget(const MaterialApp(home: Dashboard()));
  //   // to be added
  // });

  // //Test the Customer Stream
  // testWidgets('Customer Stream Test Widgets', (WidgetTester tester) async {
  //   await tester.pumpWidget(const CustomerScreen());
  //   // Let the snapshots stream fire a snapshot.
  //   expect(find.byKey(const Key("Stream Customer")), findsOneWidget);
  // });

  // testWidgets('Customer List Screen Test Widgets', (WidgetTester tester) async {
  //   // Generates the Customer List
  //   await tester.pumpWidget(StreamProvider<List<Customer>>.value(
  //     value: CustomerService().customers,
  //     initialData: const [],
  //     child: const CustomerListWidget(),
  //   ));
  //   //Currently Its empty idont know why

  //   expect(find.byKey(const Key("Spinning")), findsOneWidget);

  //   await tester.pump();

  //   //Taps one customer Info from the list
  //   // await tester.tap(find.byType(ElevatedButton, skipOffstage: false));
  //   // await tester.pumpAndSettle();
  //   //expect(find.byKey(const Key("Customer List from CustomerListWidget")),
  // });

  //Tests the Order Stream
  testWidgets('Order Stream Test Widgets', (WidgetTester tester) async {
    await tester.pumpWidget(const OrderListScreen());
    expect(find.byKey(const Key("Stream Order")), findsOneWidget);

    // //Taps the search icon
    // await tester.tap(find.byType(IconButton));
    // expect(find.byKey(const Key("Search Customer")), findsOneWidget);
  });

  // Tests for the Order List Screen
  testWidgets('Order List Screen Test Widgets', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(StreamProvider<List<Order>>.value(
      value: OrderService().orders,
      initialData: const [],
      child: const OrderListWidget(),
    ));
    await tester.pump();
    //Same here, it's still empty T.T
    expect(find.byKey(const Key("Spin")), findsOneWidget);

    // //Taps one order Info from the list
    // await tester.tap(find.byType(Container));
    // await tester.pump();
    // expect(find.byKey(const Key("Order Info Card")), findsOneWidget);
  });

  testWidgets('Calendar Screen Test Widgets', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: CalendarScreen()));
    await tester.pumpAndSettle();
  });
}
