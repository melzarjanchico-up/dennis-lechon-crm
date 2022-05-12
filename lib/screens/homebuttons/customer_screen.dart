import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/add_customer_new.dart';
//import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/addcustomer_popup.dart';
import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/services/customer_database_services.dart';
import 'package:provider/provider.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/customer_list.dart';
import 'package:dennis_lechon_crm/widgets/search.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter/services.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Stream Builder
    return Directionality(
      textDirection: TextDirection.ltr,
      child: StreamBuilder<List<Customer>>(
          stream: CustomerService().customers,
          builder: (context, snapshot) {
            if (!snapshot.hasError) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center(child: Text("Offline. Try again later."));
                case ConnectionState.waiting:
                  return const Loading();
                default:
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: const Color(0xFFF1A22C),
                      title: Text(
                        "Customer List",
                        style: GoogleFonts.oxygen(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      centerTitle: true,
                      actions: [
                        IconButton(
                          onPressed: () {
                            showSearch(
                              context: context,
                              delegate: SearchCustomer(),
                            );
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ],
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddCustomer()));
                      },
                      child: const Icon(
                        Icons.add,
                        size: 26.0,
                      ),
                      backgroundColor: const Color(0xFFF1A22C),
                    ),
                    body: StreamProvider<List<Customer>>.value(
                      value:
                          CustomerService().customers, // as in wala koy mabuhat
                      initialData: const [],
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 45.0),
                          child: const CustomerListWidget()),
                    ),
                  );
              }
            } else {
              return Center(
                child: Text(
                  "Something went wrong. Please contact admin. ${snapshot.error}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
          }),
    );
  }
}

Widget imageProfile() {
  return Center(
    child: Stack(children: <Widget>[
      const CircleAvatar(
        radius: 40.0,
        backgroundImage: AssetImage('assets/images/user.png'),
      ),
      Positioned(
          bottom: 20.0,
          right: 20.0,
          child: Icon(
            Icons.camera_alt,
            color: Colors.white.withOpacity(0.5),
            size: 33.0,
          )),
    ]),
  );
}
