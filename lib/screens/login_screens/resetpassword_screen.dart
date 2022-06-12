import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key, required this.firestore}) : super(key: key);
  final FirebaseFirestore firestore;
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
                key: Key("Password Key"),
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
                        reusableTextField(
                            "Enter Email Id",
                            Icons.person_outline,
                            false,
                            _emailTextController,
                            const Key("PassFromResetPass Key")),
                        const SizedBox(
                          height: 20,
                        ),
                        firebaseUIButton(context, "Reset Password", () {
                          FirebaseAuth.instance
                              .sendPasswordResetEmail(
                                  email: _emailTextController.text)
                              .then((value) {
                            debugPrint("Reset Password is successful!");
                            ScaffoldMessenger.of(context).showSnackBar(
                                generalSnackbar(
                                    'Please check your email to reset password.'));
                            Navigator.of(context).pop();
                          }).onError((FirebaseAuthException error, stackTrace) {
                            var errorcode = error.code;
                            var msg = '';

                            switch (errorcode) {
                              case 'invalid-email':
                                msg = 'Inputted email is invalid. Try again.';
                                break;
                              case 'user-disabled':
                                msg =
                                    'This user has been disabled from the app.';
                                break;
                              case 'user-not-found':
                                msg =
                                    'This email does not have an account yet.';
                                break;
                              case 'wrong-password':
                                msg =
                                    'Inputted password was incorrect. Try again.';
                                break;
                              default:
                                msg =
                                    'Log-in failed. Please contact the administrator.';
                            }

                            // Error Prompt here
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Login Error"),
                                    content: Text(msg),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("OK"))
                                    ],
                                  );
                                });
                            // Ends here
                          });
                        }, const Key("ResetPassword Key"))
                      ],
                    ),
                  ))),
            ])));
  }
}
