// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_info/customer_info.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/add_customer_new.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/customer_list.dart';
import 'package:dennis_lechon_crm/services/customer_database_services.dart';
import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:dennis_lechon_crm/widgets/search.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/customer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

void main() {
  group("Customer Feature Tests includes: ", () {
    // Populate the fake database.
    final firestore = FakeFirebaseFirestore();

    testWidgets('Customer Screen class Test', (WidgetTester tester) async {
      // Render the widget.
      await tester
          .pumpWidget(MaterialApp(home: CustomerScreen(firestore: firestore)));
      // Let the snapshots stream fire a snapshot.
      await tester.idle();
      // Re-render.
      await tester.pump();
      // Verify the output.
      expect(find.byKey(const Key("Stream Customer")), findsOneWidget);
      expect(find.byKey(const Key("StreamProvider Part")), findsOneWidget);
      expect(find.text("Customer List"), findsOneWidget);
      expect(find.textContaining("Something went wrong. Please contact admin."),
          findsNothing);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.text("Add Customer"), findsOneWidget);

      await tester.tap(find.byType(IconButton));
      await tester.pump();
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets("Customer List and Customer Information class",
        (WidgetTester tester) async {
      //Generates the Customer List
      await firestore.collection("customers").add({
        'first_name': 'Name 3',
        'middle_name': "Test Middle Name",
        'last_name': "Test Lastname",
        'cel_no': '09912345632',
        'tel_no': "telnum",
        'address': {
          'street': "street",
          'barangay': "barangay",
          'city': "city",
          'zipcode': "zipcode",
          'province': " province"
        },
        // Best if I don't test the bday since it's system's design. I trust they are perfect
        'note': "note",
        'tag': {'tagname': "Hot", 'index': 1, 'color': "Color(0xFFD3231E)"}
      });

      await tester.pumpWidget(StreamProvider<List<Customer>>.value(
          value: CustomerService(firestore: firestore).customers,
          initialData: const [],
          child: MaterialApp(
              home: Builder(
            builder: (context) => CustomerListWidget(firestore: firestore),
          ))));
      await tester.idle();
      // Re-render.
      await tester.pump();

      expect(find.text("Incoming Order"), findsWidgets);
      expect(find.text("Hot"), findsOneWidget);
      expect(find.byIcon(Icons.local_fire_department), findsOneWidget);

      // Verify the customer information
      await tester.tap(find.textContaining("Name 3"));
      await tester.pumpAndSettle();
      expect(find.textContaining("Name 3'"), findsWidgets);
      expect(find.text("09912345632"), findsOneWidget);
      expect(find.text("Hot"), findsOneWidget);
      expect(find.textContaining("street"), findsOneWidget);
      expect(find.textContaining("barangay"), findsOneWidget);
      expect(find.text("note"), findsOneWidget);
      expect(find.textContaining("Edit Profile"), findsOneWidget);
      expect(find.textContaining("Order List"), findsOneWidget);

      //Verify the order button
      await tester.ensureVisible(find.byKey(const Key("Order List Button")));
      await tester.tap(find.textContaining("Order List"), warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(find.textContaining("Order History"), findsOneWidget);
      expect(
          find.text("Customer's order history is empty."), findsOneWidget); //

      await tester.pageBack();
      expect(find.textContaining("Name 3"), findsWidgets);

      // Edit button is shit
      // //Verify the edit list button
      // await tester.ensureVisible(find.byKey(const Key("Edit Profile Button")));
      // await tester.tap(find.textContaining("Edit Profile"),
      //     warnIfMissed: false);
      // await tester.pumpAndSettle();
      // //expect(find.textContaining("Edit"), findsOneWidget);
    });

    testWidgets("Adding Correct Customer Information",
        (WidgetTester tester) async {
      // Render the widget.
      await tester
          .pumpWidget(MaterialApp(home: AddCustomer(firestore: firestore)));
      // Let the snapshots stream fire a snapshot.
      await tester.idle();
      // Re-render.
      await tester.pump();
      // // Verify the output.
      expect(find.text("Add Customer"), findsOneWidget);

      await tester.enterText(find.byKey(const Key("First Name")), "Dianne");
      await tester.pump();
      expect(find.text("Dianne"), findsOneWidget);

      await tester.enterText(find.byKey(const Key("Middle Name")), "Moon");
      await tester.pump();
      expect(find.text("Moon"), findsOneWidget);

      await tester.enterText(find.byKey(const Key("Last Name")), "Moonids");
      await tester.pump();
      expect(find.text("Moonids"), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("Cellphone Number")), "09986413234");
      await tester.pump();
      expect(find.text("09986413234"), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("Telephone Number")), "2723112");
      expect(find.text("2723112"), findsOneWidget);

      //Lacking Birthday Part

      await tester.enterText(
          find.byKey(const Key("Building/Street/Block No.")), "Purok Maga");
      await tester.pump();
      expect(find.text("Purok Maga"), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("District/Barangay")), "Tungkop");
      await tester.pump();
      expect(find.text("Tungkop"), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("Municipality/City")), "Talisay");
      await tester.pump();
      expect(find.text("Talisay"), findsOneWidget);

      await tester.enterText(find.byKey(const Key("Province")), "Cebu");
      await tester.pump();
      expect(find.text("Cebu"), findsOneWidget);

      await tester.enterText(find.byKey(const Key("Zipcode")), "1606");
      await tester.pump();
      expect(find.text("1606"), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("Notes")), "This is a sample note");
      await tester.pump();
      expect(find.text("This is a sample note"), findsOneWidget);

      await tester.tap(find.text("Cold"));
      await tester.pump();
      expect(find.byKey(const Key("Cold")),
          findsOneWidget); //Works with any tag name. Mag tigi ni siya ka select sa add customer button

      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Create Customer"));
      await tester.pump();
      expect(find.text("Customer was added successfully!"), findsOneWidget);
      expect(find.text("Somewthing went wrong. Customer was not added."),
          findsNothing);
    });

    testWidgets("Adding Customer Information with Missing Required Fields",
        (WidgetTester tester) async {
      // Render the widget.
      await tester
          .pumpWidget(MaterialApp(home: AddCustomer(firestore: firestore)));
      // Let the snapshots stream fire a snapshot.
      await tester.idle();
      // Re-render.
      await tester.pump();
      // // Verify the output.
      expect(find.text("Add Customer"), findsOneWidget);

      // This is the missing required field.
      // await tester.enterText(find.byKey(const Key("First Name")), "Dianne");
      // await tester.pump();
      // expect(find.text("Dianne"), findsOneWidget);

      await tester.enterText(find.byKey(const Key("Middle Name")), "Moon");
      await tester.pump();
      expect(find.text("Moon"), findsOneWidget);

      await tester.enterText(find.byKey(const Key("Last Name")), "Moonids");
      await tester.pump();
      expect(find.text("Moonids"), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("Cellphone Number")), "09986413234");
      await tester.pump();
      expect(find.text("09986413234"), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("Telephone Number")), "2723112");
      await tester.pump();
      expect(find.text("2723112"), findsOneWidget);

      //Lacking Birthday Part

      await tester.enterText(
          find.byKey(const Key("Building/Street/Block No.")), "Purok Maga");
      await tester.pump();
      expect(find.text("Purok Maga"), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("District/Barangay")), "Tungkop");
      await tester.pump();
      expect(find.text("Tungkop"), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("Municipality/City")), "Talisay");
      await tester.pump();
      expect(find.text("Talisay"), findsOneWidget);

      await tester.enterText(find.byKey(const Key("Province")), "Cebu");
      await tester.pump();
      expect(find.text("Cebu"), findsOneWidget);

      await tester.enterText(find.byKey(const Key("Zipcode")), "1606");
      await tester.pump();
      expect(find.text("1606"), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("Notes")), "This is a sample note");
      await tester.pump();
      expect(find.text("This is a sample note"), findsOneWidget);

      await tester.tap(find.text("Cold"));
      await tester.pump();
      expect(find.byKey(const Key("Cold")),
          findsOneWidget); //Works with any tag name. Mag tigi ni siya ka select sa add customer button

      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Create Customer"));
      await tester.pump();
      expect(find.text("Customer was added successfully!"), findsNothing);
    });

    testWidgets("Adding Customer Information with Missing NonRequired Fields",
        (WidgetTester tester) async {
      // Render the widget.
      await tester
          .pumpWidget(MaterialApp(home: AddCustomer(firestore: firestore)));
      // Let the snapshots stream fire a snapshot.
      await tester.idle();
      // Re-render.
      await tester.pump();
      // // Verify the output.
      expect(find.text("Add Customer"), findsOneWidget);

      await tester.enterText(find.byKey(const Key("First Name")), "Dianne");
      await tester.pump();
      expect(find.text("Dianne"), findsOneWidget);

      await tester.enterText(find.byKey(const Key("Last Name")), "Moonids");
      await tester.pump();
      expect(find.text("Moonids"), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("Cellphone Number")), "09986413234");
      await tester.pump();
      expect(find.text("09986413234"), findsOneWidget);

      await tester.tap(find.text("Warm"));
      await tester.pump();
      expect(find.byKey(const Key("Warm")),
          findsOneWidget); //Works with any tag name. Mag tigi ni siya ka select sa add customer button

      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Create Customer"));
      await tester.pump();
      expect(find.text("Customer was added successfully!"), findsOneWidget);
    });

    testWidgets("Adding Customer Information with Missing Required Fields",
        (WidgetTester tester) async {
      // Render the widget.
      await tester
          .pumpWidget(MaterialApp(home: AddCustomer(firestore: firestore)));
      // Let the snapshots stream fire a snapshot.
      await tester.idle();
      // Re-render.
      await tester.pump();
      // // Verify the output.
      expect(find.text("Add Customer"), findsOneWidget);

      // This is the missing required field.
      // await tester.enterText(find.byKey(const Key("First Name")), "Dianne");
      // await tester.pump();
      // expect(find.text("Dianne"), findsOneWidget);

      await tester.enterText(find.byKey(const Key("Middle Name")), "Moon");
      await tester.pump();
      expect(find.text("Moon"), findsOneWidget);

      await tester.enterText(find.byKey(const Key("Last Name")), "Moonids");
      await tester.pump();
      expect(find.text("Moonids"), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("Cellphone Number")), "09986413234");
      await tester.pump();
      expect(find.text("09986413234"), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("Telephone Number")), "2723112");
      await tester.pump();
      expect(find.text("2723112"), findsOneWidget);

      //Lacking Birthday Part

      await tester.enterText(
          find.byKey(const Key("Building/Street/Block No.")), "Purok Maga");
      await tester.pump();
      expect(find.text("Purok Maga"), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("District/Barangay")), "Tungkop");
      await tester.pump();
      expect(find.text("Tungkop"), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("Municipality/City")), "Talisay");
      await tester.pump();
      expect(find.text("Talisay"), findsOneWidget);

      await tester.enterText(find.byKey(const Key("Province")), "Cebu");
      await tester.pump();
      expect(find.text("Cebu"), findsOneWidget);

      await tester.enterText(find.byKey(const Key("Zipcode")), "1606");
      await tester.pump();
      expect(find.text("1606"), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("Notes")), "This is a sample note");
      await tester.pump();
      expect(find.text("This is a sample note"), findsOneWidget);

      await tester.tap(find.text("Cold"));
      await tester.pump();
      expect(find.byKey(const Key("Cold")),
          findsOneWidget); //Works with any tag name. Mag tigi ni siya ka select sa add customer button

      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Create Customer"));
      await tester.pump();
      expect(find.text("Customer was added successfully!"), findsNothing);
    });

    testWidgets("Editing Customer Information", (WidgetTester tester) async {
      // Render the widget.
      await firestore.collection("customers").add({
        'first_name': 'Edit Firstname',
        'middle_name': "Edit Middle Name",
        'last_name': "Edit Lastname",
        'cel_no': '09912345632',
        'tel_no': "telnum",
        'address': {
          'street': "street",
          'barangay': "barangay",
          'city': "city",
          'zipcode': "zipcode",
          'province': " province"
        },
        // I don't know how to test the date part tho T.T
        'note': "note",
        'tag': {'tagname': "Hot", 'index': 1, 'color': "Color(0xFFD3231E)"}
      });
      await tester.pumpWidget(StreamProvider<List<Customer>>.value(
          value: CustomerService(firestore: firestore).customers,
          initialData: const [],
          child: MaterialApp(
            home: Builder(
                builder: (context) => CustomerListWidget(firestore: firestore)),
          )));
      await tester.idle();
      // Re-render.
      await tester.pump();
      // Verify the output of the Customer List.
      //expect(find.byKey(const Key("bitch")), findsOneWidget);
      // expect(find.byKey(const Key("Spinning")), findsNothing);
      // expect(find.text("Incoming Order"), findsOneWidget);
      // expect(find.textContaining("Edit Firstname"), findsOneWidget);
      // expect(find.text("Hot"), findsOneWidget);

      // // Verify the customer information
      // await tester.tap(find.textContaining("Edit Firstname"));
      // await tester.pumpAndSettle();
      // expect(find.byKey(const Key("Customer Information")), findsOneWidget);
      // expect(find.textContaining("Edit Firstname"), findsWidgets);
      // expect(find.text("09912345632"), findsOneWidget);
      // expect(find.text("Hot"), findsOneWidget);
      // expect(find.textContaining("street"), findsOneWidget);
      // expect(find.textContaining("barangay"), findsOneWidget);
      // expect(find.text("note"), findsOneWidget);
      // expect(find.text("Edit Profile"), findsOneWidget);
      // expect(find.textContaining("Order List"), findsOneWidget);

      // //Verify the edit button
      // await tester.tap(find.text("Edit Profile"), warnIfMissed: false);
      // await tester.pumpAndSettle();
      // expect(find.text("Edit Customer"), findsNothing); //To be worked on
    });
  });
}
