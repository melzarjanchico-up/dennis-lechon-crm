// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dennis_lechon_crm/models/order.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/order_screen.dart';
import 'package:dennis_lechon_crm/screens/order_screen/order_list/add_order.dart';
import 'package:dennis_lechon_crm/screens/order_screen/order_list/order_list.dart';
import 'package:dennis_lechon_crm/services/order_database_services.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

void main() {
  group("Order Features Test Include: ", () {
    // Populate the fake database.
    final firestore = FakeFirebaseFirestore();
    testWidgets("Order Stream ", (WidgetTester tester) async {
      // Render the widget.
      await tester
          .pumpWidget(MaterialApp(home: OrderListScreen(firestore: firestore)));
      // Let the snapshots stream fire a snapshot.
      await tester.idle();
      // Re-render.
      await tester.pump();
      // Verify the output.
      expect(find.byKey(const Key("Stream Order")), findsOneWidget);
      expect(find.byKey(const Key("OrderProvider Part")), findsOneWidget);
      expect(find.text("Order List"), findsOneWidget);
      expect(find.textContaining("Something went wrong. Please contact admin."),
          findsNothing);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.text("Order Fillout"), findsOneWidget);

      await tester.tap(find.byType(IconButton));
      await tester.pump();
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets("Order List and Order Information ",
        (WidgetTester tester) async {
      final customer = await firestore.collection("customers").add({
        'first_name': 'Test FirstName',
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

      await customer.collection("orders").add({
        'customer': {
          'id': customer.id,
          'first_name': "Test FirstName",
          'last_name': "Test LastName",
          'address': "Test Address",
          'contact': "09943215642",
        },
        'added_date': Timestamp.now(),
        'delivery_date': "2022-09-16 19:11:00.000", // Know sample format
        'is_rush': true,
        'is_delivery': true,
        'payment_status': "Paid",
        'delivery_fee': 5000,
        'details': {'small': 1, 'medium': 2, 'large': 3, 'xlarge': 4},
      });

      await tester.pumpWidget(StreamProvider<List<Order>>.value(
          value: OrderService(firestore: firestore).orders,
          initialData: const [],
          child: MaterialApp(
              home: Builder(
            builder: (context) => OrderListWidget(firestore: firestore),
          ))));
      await tester.idle();
      // Re-render.
      await tester.pump();

      expect(find.textContaining("Order #"), findsOneWidget);
      expect(find.byIcon(Icons.alarm), findsOneWidget);
      expect(find.textContaining("2022"), findsOneWidget);

      await tester.tap(find.textContaining("Order #"));
      await tester.pumpAndSettle();
      expect(find.textContaining("Test FirstName"), findsWidgets);
      expect(find.text("Test Address"), findsOneWidget);
      expect(find.text("09943215642"), findsOneWidget);
      expect(find.text("PAID"), findsOneWidget);
      expect(find.text("DELIVERY"), findsOneWidget);
      expect(find.text("RUSH"), findsOneWidget);
      expect(find.text("5000"), findsOneWidget);
      expect(find.textContaining("Lechon"), findsWidgets);
      expect(find.textContaining("10 items"), findsOneWidget);
      expect(find.textContaining("75000"), findsOneWidget);
      expect(find.text("Edit"), findsOneWidget);
      expect(find.byIcon(Icons.delivery_dining_outlined), findsOneWidget);
      expect(find.byIcon(Icons.alarm), findsNWidgets(2));
      expect(
          find.byIcon(Icons.account_balance_wallet_outlined), findsOneWidget);
      expect(find.byIcon(Icons.delete_forever_rounded), findsOneWidget);
    });

    testWidgets("Delete Order Information ", (WidgetTester tester) async {
      final customer = await firestore.collection("customers").add({
        'first_name': 'Test FirstName',
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

      await customer.collection("orders").add({
        'customer': {
          'id': customer.id,
          'first_name': "Test FirstName",
          'last_name': "Test LastName",
          'address': "Test Address",
          'contact': "09943215642",
        },
        'added_date': Timestamp.now(),
        'delivery_date': "2022-09-16 19:11:00.000", // Know sample format
        'is_rush': true,
        'is_delivery': true,
        'payment_status': "Paid",
        'delivery_fee': 5000,
        'details': {'small': 1, 'medium': 2, 'large': 3, 'xlarge': 4},
      });

      await tester.pumpWidget(StreamProvider<List<Order>>.value(
          value: OrderService(firestore: firestore).orders,
          initialData: const [],
          child: MaterialApp(
              home: Builder(
            builder: (context) => OrderListWidget(firestore: firestore),
          ))));
      await tester.idle();
      // Re-render.
      await tester.pump();

      await tester.tap(find.textContaining("Test FirstName"));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byIcon((Icons.delete_forever_rounded)));
      await tester.tap(find.byIcon(Icons.delete_forever_rounded));
      await tester.pumpAndSettle();
      expect(find.textContaining("Are you sure you want to delete this order?"),
          findsOneWidget);

      await tester.tap(find.text("Confirm"));
      await tester.pump();
      expect(find.byType(ScaffoldMessenger), findsOneWidget);
      expect(find.textContaining("Order #"), findsNothing);
    });

    testWidgets("Add Order in an Existing Customer",
        (WidgetTester tester) async {
      await firestore.collection("customers").add({
        'first_name': 'Test FirstName',
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

      await tester
          .pumpWidget(MaterialApp(home: AddOrder(firestore: firestore)));
      await tester.idle();
      // Re-render.
      await tester.pump();
      expect(find.text("Order Fillout"), findsOneWidget);

      await tester.tap(find.byIcon(Icons.person_search_outlined));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.person_sharp));
      await tester.pumpAndSettle();
      expect(find.textContaining("street"), findsOneWidget);
      expect(find.text("09912345632"), findsOneWidget);

      await tester.tap(find.text("Status"));
      await tester.tap(find.text("Paid"), warnIfMissed: false);
      expect(find.text("Paid"), findsOneWidget);

      await tester.tap(find.text("Delivery Date & Time:"), warnIfMissed: false);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byType(DateTimeField), "Mon, 20-Jun-2022, 10:25AM");
      await tester.pumpAndSettle();
      expect(find.textContaining("2022"), findsOneWidget);

      await tester.tap(find.text("RUSH?"), warnIfMissed: false);
      await tester.pump();
      expect(find.text("Delivery fee"), findsNothing);

      await tester.ensureVisible(find.textContaining("Create Order"));
      await tester.tap(find.byKey(const Key("addXLLechon")),
          warnIfMissed: false);
      await tester.pump();
      //expect(find.textContaining("8000.0"), findsOneWidget);

      await tester.tap(find.byKey(const Key("addLargeLechon")),
          warnIfMissed: false);
      await tester.pump();
      //expect(find.textContaining("15000.0"), findsOneWidget);

      //expect(find.textContaining("15000.0"), findsOneWidget);
      //expect(find.textContaining("2 items"), findsOneWidget);

      await tester.tap(find.textContaining("Create Order"),
          warnIfMissed: false);
      await tester.pump();
      expect(find.byType(ScaffoldMessenger), findsOneWidget);
    });
  });
}
