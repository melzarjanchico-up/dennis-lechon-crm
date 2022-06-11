import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/widgets/style.dart';
import 'package:dennis_lechon_crm/screens/home_screen_new/nav_bar.dart';
import 'package:dennis_lechon_crm/screens/home_screen_new/components/body.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key, required this.firestore}) : super(key: key);
  final FirebaseFirestore firestore;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                expandedHeight: 65,
                centerTitle: true,
                backgroundColor: AppColors.redColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(40),
                  ),
                ),
                title: const Text('Lech Go!',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                pinned: false,
                floating: true,
                forceElevated: innerBoxIsScrolled),
          ];
        },
        body: Body(firestore: firestore),
      ),
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(60.0),
      //   child: AppBar(
      //           automaticallyImplyLeading: false,
      //     shape: const RoundedRectangleBorder(
      //         borderRadius: BorderRadius.only(
      //             bottomLeft: Radius.circular(40),
      //             bottomRight: Radius.circular(40))),
      //     title: const Text('Lech Go!',
      //         style: TextStyle(
      //             fontFamily: 'Montserrat',
      //             fontSize: 22,
      //             color: Colors.white,
      //             fontWeight: FontWeight.bold)),
      //     centerTitle: true,
      //     backgroundColor: AppColors.redColor,
      //     // shape: const RoundedRectangleBorder(
      //     //   borderRadius: BorderRadius.vertical(
      //     //     bottom: Radius.circular(40),
      //     //   ),
      //     // ),
      //     elevation: 0,
      //   ),
      // ),
      drawer: NavBar(
        firestore: firestore,
      ),
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
    );
  }
}
