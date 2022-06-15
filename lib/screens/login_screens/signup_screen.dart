import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/widgets/reusable_widget.dart';
import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class SignUp extends StatefulWidget {
  const SignUp({Key? key, required this.firestore}) : super(key: key);
  final FirebaseFirestore firestore;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  late final FirebaseFirestore firestore;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            key: const Key("Sign Up"),
            backgroundColor: const Color.fromARGB(255, 185, 17, 5),
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                "Sign Up Form",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            body: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                  child: Column(
                    children: <Widget>[
                      reusableTextField(
                          "Enter Email",
                          Icons.person_outline,
                          false,
                          _emailTextController,
                          const Key("EmailFromSignUp Key")),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField(
                          "Enter Password",
                          Icons.lock_outline,
                          true,
                          _passwordTextController,
                          const Key("PassFromSignUp Key")),
                      const SizedBox(
                        height: 5,
                      ),
                      firebaseUIButton(context, "Sign Up", () {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                          debugPrint("Created New Account");
                          ScaffoldMessenger.of(context).showSnackBar(
                              generalSnackbar('Account Created Successfully'));
                          Navigator.of(context).pop();
                        }).onError((FirebaseAuthException error, stackTrace) {
                          var errorcode = error.code;
                          var msg = '';

                          switch (errorcode) {
                            case 'invalid-email':
                              msg = 'Inputted email is invalid. Try again.';
                              break;
                            case 'user-disabled':
                              msg = 'This user has been disabled from the app.';
                              break;
                            case 'user-not-found':
                              msg = 'This email does not have an account yet.';
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
                      }, const Key("SignUp Key"))
                    ],
                  ),
                ))),
          );
  }
}
