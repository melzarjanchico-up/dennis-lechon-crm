import 'package:dennis_lechon_crm/screens/homebuttons/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/widgets/style.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/customer_screen.dart';
// import 'package:dennis_lechon_crm/screens/homebuttons/order_screen.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/calendar_screen.dart';
import 'package:dennis_lechon_crm/screens/login_screens/signin_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key, required this.firestore}) : super(key: key);
  final FirebaseFirestore firestore;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Dennis Lechon'),
            accountEmail: const Text('dennislechon@gmail.com'),
            currentAccountPicture: Row(
              children: [
                Image.asset(
                  'assets/images/dennislogo.png',
                  width: 75,
                  height: 75,
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
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const SignIn())));
            },
          ),
        ],
      ),
    );
  }
}
