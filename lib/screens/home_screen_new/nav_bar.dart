import 'package:dennis_lechon_crm/screens/homebuttons/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dennis_lechon_crm/widgets/style.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/customer_screen.dart';
// import 'package:dennis_lechon_crm/screens/homebuttons/order_screen.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/calendar_screen.dart';
import 'package:dennis_lechon_crm/screens/login_screens/signin_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  // const NavBar({Key? key, required this.firestore}) : super(key: key);
  late FirebaseFirestore firestore;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String eMail, password;
  late User? user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() {
    user = _auth.currentUser;
    setState(() {});
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _loadCurrentUser();
  // }
  // if(_newUser!=null)
  //      {

  //        final  user =_auth.currentUser;

  //            if(user!=null)
  //                  {
  //                    final email = user.email;
  //                     print(email);
  //                   }
  //       }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            //accountName: const Text(" "),
            accountEmail: Text("${user?.email}"),
            currentAccountPicture: Row(
              children: [
                Image.asset(
                  'assets/images/dennislogo.png',
                  width: 70,
                  height: 70,
                ),
              ],
            ),
            decoration: const BoxDecoration(
              color: AppColors.redColor,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('assets/images/lechon_loginpage.png')),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_add_alt_1_outlined),
            title: const Text('Customer List'),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => CustomerScreen(
                            firestore: firestore,
                          ))));
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Order List'),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => OrderListScreen(
                            firestore: firestore,
                          ))));
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month_outlined),
            title: const Text('My Calendar'),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => CalendarScreen(
                            firestore: firestore,
                          ))));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => SignIn(firestore: firestore))));
            },
          ),
        ],
      ),
    );
  }
}
