import 'package:dennis_lechon_crm/screens/customer_screen/user_preferences.dart';
<<<<<<< HEAD
<<<<<<< HEAD
//import 'package:dennis_lechon_crm/widgets/loading.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/user.dart';
//import 'package:dennis_lechon_crm/screens/customer_screen/user_preferences.dart';
=======
import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/user.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/user_preferences.dart';
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/user.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/user_preferences.dart';
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
import 'package:dennis_lechon_crm/screens/customer_screen/customer_picture.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/button_widget.dart';

class CustomerInfo extends StatefulWidget {
  const CustomerInfo({Key? key}) : super(key: key);

  @override
  State<CustomerInfo> createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
<<<<<<< HEAD
    const user = UserPreferences.myUser;
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
=======
=======
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
    final user = UserPreferences.myUser;
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
<<<<<<< HEAD
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 15), // for Info Space
          buildInfo(user),
          const SizedBox(height: 15), // for Notes Space
          Center(child: buildNotes(user)),
<<<<<<< HEAD
<<<<<<< HEAD
          Column(children: const <Widget>[
=======
          Column(children: <Widget>[
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
          Column(children: <Widget>[
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
            SizedBox(height: 10),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            const SizedBox(height: 25, width: 15), // for Edit Profile Button
            Center(child: buildEditProfileButton()),
            const SizedBox(height: 25, width: 15), // for Order List Button
            Center(child: buildOrderListButton()),
          ])
        ],
      ),
    );
  }

  Widget buildInfo(User user) => Column(
        children: [
          Text(
            user.name,
<<<<<<< HEAD
<<<<<<< HEAD
            style: const TextStyle(
=======
            style: TextStyle(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
            style: TextStyle(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
                fontSize: 20.0,
                color: Color.fromARGB(255, 68, 82, 88),
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            user.number,
<<<<<<< HEAD
<<<<<<< HEAD
            style: const TextStyle(
=======
            style: TextStyle(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
            style: TextStyle(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
                fontSize: 15.0,
                color: Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300),
          ),
          Text(
            user.address,
<<<<<<< HEAD
<<<<<<< HEAD
            style: const TextStyle(
=======
            style: TextStyle(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
            style: TextStyle(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
                fontSize: 15.0,
                color: Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300),
          ),
          Text(
            user.age,
<<<<<<< HEAD
<<<<<<< HEAD
            style: const TextStyle(
=======
            style: TextStyle(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
            style: TextStyle(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
                fontSize: 15.0,
                color: Colors.black45,
                letterSpacing: 1.0,
                fontWeight: FontWeight.w300),
          ),
<<<<<<< HEAD
<<<<<<< HEAD
          const SizedBox(
            height: 20,
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
=======
=======
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
          SizedBox(
            height: 20,
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
<<<<<<< HEAD
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
<<<<<<< HEAD
<<<<<<< HEAD
                        const Text(
=======
                        Text(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
                        Text(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
                          "Birthday",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w300),
                        ),
<<<<<<< HEAD
<<<<<<< HEAD
                        const SizedBox(
=======
                        SizedBox(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
                        SizedBox(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
                          height: 7,
                        ),
                        Text(
                          user.birthday,
<<<<<<< HEAD
<<<<<<< HEAD
                          style: const TextStyle(
=======
                          style: TextStyle(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
                          style: TextStyle(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
<<<<<<< HEAD
<<<<<<< HEAD
                        const Text(
=======
                        Text(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
                        Text(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
                          "Last Ordered",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w300),
                        ),
<<<<<<< HEAD
<<<<<<< HEAD
                        const SizedBox(
=======
                        SizedBox(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
                        SizedBox(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
                          height: 7,
                        ),
                        Text(
                          user.lastOrder,
<<<<<<< HEAD
<<<<<<< HEAD
                          style: const TextStyle(
=======
                          style: TextStyle(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
                          style: TextStyle(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
<<<<<<< HEAD
<<<<<<< HEAD
                        const Text(
=======
                        Text(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
                        Text(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
                          "Tags",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w300),
                        ),
<<<<<<< HEAD
<<<<<<< HEAD
                        const SizedBox(
=======
                        SizedBox(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
                        SizedBox(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
                          height: 7,
                        ),
                        Text(
                          user.tag,
<<<<<<< HEAD
<<<<<<< HEAD
                          style: const TextStyle(
=======
                          style: TextStyle(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
                          style: TextStyle(
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
                              color: Colors.red,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget buildOrderListButton() => ElevatedButton(
<<<<<<< HEAD
<<<<<<< HEAD
        child: const Text(' ORDER LIST '),
=======
        child: Text(' ORDER LIST '),
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
        child: Text(' ORDER LIST '),
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
        onPressed: () async {
          setState(() {
            loading = true;
          });
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            loading = false;
          });
        },
        style: ElevatedButton.styleFrom(
<<<<<<< HEAD
<<<<<<< HEAD
          shape: const StadiumBorder(),
          primary: const Color(0xFFD3231E),
          onPrimary: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
=======
=======
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
          shape: StadiumBorder(),
          primary: const Color(0xFFD3231E),
          onPrimary: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 34, vertical: 20),
<<<<<<< HEAD
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
        ),
      );

  Widget buildEditProfileButton() => ButtonWidget(
        text: 'EDIT PROFILE',
        onClicked: () {},
      );

  Widget buildNotes(User user) => Card(
        child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              // gi ontap para sa future na edit notes :)
              debugPrint('Card tapped.');
            },
            child: Container(
                width: 350,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.white,
                ),
                child: Stack(children: [
                  Positioned(
                    top: 15,
                    right: 125,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 35,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1A22C),
                        borderRadius: BorderRadius.circular(36),
                      ),
<<<<<<< HEAD
<<<<<<< HEAD
                      child: const Text('    NOTES    ',
=======
                      child: Text('    NOTES    ',
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
=======
                      child: Text('    NOTES    ',
>>>>>>> 877ca1c6f8c61098861a4dd567d39ddda10ef697
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  )
                ]))),
      );
}
