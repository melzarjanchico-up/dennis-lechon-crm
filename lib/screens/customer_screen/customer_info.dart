import 'package:dennis_lechon_crm/screens/customer_screen/user_preferences.dart';
import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/user.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/user_preferences.dart';
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
    final user = UserPreferences.myUser;
    return loading
        ? const Loading()
        : Scaffold(
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: user.imagePath,
                  onClicked: () async {},
                ),
                const SizedBox(height: 15), // for Info Space
                buildInfo(user),
                const SizedBox(height: 15), // for Notes Space
                Center(child: buildNotes(user)),
                Column(children: <Widget>[
                  SizedBox(height: 10),
                ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                          height: 25, width: 15), // for Edit Profile Button
                      Center(child: buildEditProfileButton()),
                      const SizedBox(
                          height: 25, width: 15), // for Order List Button
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
            style: TextStyle(
                fontSize: 20.0,
                color: Color.fromARGB(255, 68, 82, 88),
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            user.number,
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300),
          ),
          Text(
            user.address,
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300),
          ),
          Text(
            user.age,
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.black45,
                letterSpacing: 1.0,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 20,
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Birthday",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          user.birthday,
                          style: TextStyle(
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
                        Text(
                          "Last Ordered",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          user.lastOrder,
                          style: TextStyle(
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
                        Text(
                          "Tags",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          user.tag,
                          style: TextStyle(
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
        child: Text(' ORDER LIST '),
        onPressed: () async {
          setState(() {
            loading = true;
          });
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            loading = false;
          });
          // Navigator.push(
          // context,
          // MaterialPageRoute(
          // builder: (context) => const OrderListScreen()));
        },
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          primary: const Color(0xFFD3231E),
          onPrimary: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 34, vertical: 20),
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
                      child: Text('    NOTES    ',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  )
                ]))),
      );
}
