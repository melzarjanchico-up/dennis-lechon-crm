// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter/material.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:dennis_lechon_crm/main.dart' as app;

// void main() {
//   group("Sample App Test", () {
//     IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//     testWidgets("full app test", (tester) async {
//       app.main();
//       await tester.pumpAndSettle();
//       tester.enterText(find.byKey(const Key("Email Key")), 'test123@gmail.com');
//       tester.enterText(find.byKey(const Key("Pass Key")), 'test12345');
//       await tester.pumpAndSettle();
//       await tester.tap(find.text("LOG IN"));
//       await tester.pumpAndSettle();
//       expect(find.textContaining("Customer"), findsOneWidget);
//       await tester.pumpAndSettle(const Duration(seconds: 1));
//     });
//   });
// }
