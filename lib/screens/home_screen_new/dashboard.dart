import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/screens/home_screen_new/components/body.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      body: Body(),
    );
  }
}
