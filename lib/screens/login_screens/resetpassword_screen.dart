import 'package:dennis_lechon_crm/widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: const Color.fromARGB(255, 185, 17, 5),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                "Reset Your Password",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            body: Stack(children: <Widget>[
              logoWidget('assets/images/lechon_loginpage.png'),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextField("Enter Email Id",
                            Icons.person_outline, false, _emailTextController),
                        const SizedBox(
                          height: 20,
                        ),
                        firebaseUIButton(context, "Reset Password", () {
                          FirebaseAuth.instance
                              .sendPasswordResetEmail(
                                  email: _emailTextController.text)
                              .then((value) => Navigator.of(context).pop());
                        })
                      ],
                    ),
                  ))),
            ])));
  }
}
