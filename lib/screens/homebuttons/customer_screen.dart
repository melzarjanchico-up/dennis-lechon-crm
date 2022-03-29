import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/services/firebase_database_services.dart';
import 'package:provider/provider.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/customer_list.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/customer_popup.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return StreamProvider<List<Customer>>.value(
      value: CustomerService().customers,
      initialData: const [],
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFF1A22C),
            title: const Text("Customer List"),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      contentPadding: EdgeInsets.only(top: 0.0),
                      content: Stack(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 45,
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                              color: Color(0xFFD3231E),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Add Customer",
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.0,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Positioned(
                            right: -40.0,
                            top: -40.0,
                            child: InkResponse(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.close),
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 55, 15, 0),
                                  child: imageProfile(),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 6),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Customer Name',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 6, 15, 6),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Contact Number',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 6, 15, 6),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Address',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 6, 15, 6),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Birthday',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 6, 15, 6),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Age',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 6, 15, 6),
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      border: const OutlineInputBorder(),
                                      hintText: 'Tag',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: ElevatedButton(
                                    child: Text("     CREATE     "),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                      } else {
                                        return null;
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color(0xFFD3231E),
                                      onPrimary: Colors.white,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      minimumSize: const Size(75, 40),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
              /*await CustomerService().addCustomer(
                  "Ariana",
                  "Paquibot",
                  "Grande",
                  "6015",
                  "Basak",
                  "Lapu-Lapu",
                  "123",
                  "456",
                  "Heehee",
                  "Warm",
                  2,
                  "Color(0xFFF1A22C)");
              */
            },
            icon: Icon(
              Icons.add_circle_outline,
              size: 26.0,
            ),
            backgroundColor: const Color(0xFFF1A22C),
            label: Text('Add Customer'),
          ),
          body: StreamBuilder<List<Customer>>(
            stream: CustomerService().customers,
            builder: (context, snapshot) {
              if (!snapshot.hasError) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text("Offline. Try again later.");
                  case ConnectionState.waiting:
                    return const Loading();
                  case ConnectionState.done:
                  case ConnectionState.active:
                    return const CustomerListWidget();
                  default:
                    return const Text(
                        "Something went wrong. Please contact admin");
                }
              } else {
                return const Text(
                    "Something went wrong. Please contact admin.");
              }
            },
          )),
    );
  }
}

Widget imageProfile() {
  return Center(
    child: Stack(children: <Widget>[
      CircleAvatar(
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

/*
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF1A22C),
          title: const Text("Customer List"),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  await CustomerService().addCustomer("Ariana", "Paquibot", "Grande", "6015", "Basak", "Lapu-Lapu", "123", "456", "Heehee", "Warm", 2, "Color(0xFFF1A22C)");
                },
                child: const Icon(
                  Icons.account_circle,
                  size: 26.0,
                ),
              )
            )
          ],
        ),
        //body: const CustomerListWidget(),
      ),
*/