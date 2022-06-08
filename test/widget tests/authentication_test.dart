import 'package:dennis_lechon_crm/main.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/screens/login_screens/resetpassword_screen.dart';
import 'package:dennis_lechon_crm/screens/login_screens/signin_screen.dart';
import 'package:dennis_lechon_crm/screens/login_screens/signup_screen.dart';
import 'mock.dart';

void main() {
  //This is for creating a Mock for Firebase.initialize
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets('Project LechGo Main Test Widget', (WidgetTester tester) async {
    final firestore = FakeFirebaseFirestore();
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(firestore: firestore));
    await tester.pumpAndSettle();
  });

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
}
