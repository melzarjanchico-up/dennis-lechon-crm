//import 'package:dennis_lechon_crm/utils/color_utils.dart';
import 'package:dennis_lechon_crm/widgets/reusable_widget.dart';
import "package:flutter/material.dart";

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container (
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("3M_Dennis_logo.jpg"),
                const SizedBox(
                  height: 30,
                )
              ]
            )
          ),
        )
      )
    );
}