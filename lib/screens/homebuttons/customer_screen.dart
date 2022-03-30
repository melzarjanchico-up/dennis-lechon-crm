import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/services/firebase_database_services.dart';
import 'package:provider/provider.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/customer_list.dart';
import 'package:dennis_lechon_crm/widgets/search.dart';

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
          floatingActionButton: floatingAddCustomerButton(context, _formKey),
          body: StreamBuilder<List<Customer>>(
            stream: CustomerService().customers,
            builder: (context, snapshot) {
              if (!snapshot.hasError) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text("Offline. Try again later.");
                  case ConnectionState.waiting:
                    return const Loading();
                  default:
                    return Container(
                        margin: const EdgeInsets.only(bottom: 45.0),
                        child: const CustomerListWidget());
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

ValueNotifier _isLoadingNotifier = ValueNotifier(false);

@override
Widget floatingAddCustomerButton(
    BuildContext context, GlobalKey<FormState> _formKey) {
  final TextEditingController _firstNameCtr = TextEditingController();
  final TextEditingController _lastNameCtr = TextEditingController();
  final TextEditingController _middleNameCtr = TextEditingController();
  final TextEditingController _celNumCtr = TextEditingController();
  final TextEditingController _telNumCtr = TextEditingController();
  final TextEditingController _cityCtr = TextEditingController();
  final TextEditingController _barangayCtr = TextEditingController();
  final TextEditingController _zipcodeCtr = TextEditingController();
  final TextEditingController _noteCtr = TextEditingController();

  return FloatingActionButton(
    onPressed: () async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: const EdgeInsets.only(top: 0.0),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 45,
                          alignment: Alignment.topCenter,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD3231E),
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            // ignore: unnecessary_const
                            child: const Text(
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
                            child: const CircleAvatar(
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
                                padding:
                                    const EdgeInsets.fromLTRB(15, 55, 15, 0),
                                child: imageProfile(),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: TextField(
                                          controller: _firstNameCtr,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            labelText: 'First Name',
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Flexible(
                                      child: TextField(
                                          controller: _middleNameCtr,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            labelText: 'Middle Name',
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Flexible(
                                      child: TextField(
                                          controller: _lastNameCtr,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            labelText: 'Last Name',
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: TextField(
                                          controller: _celNumCtr,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            labelText: 'Cellphone No.',
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Flexible(
                                      child: TextField(
                                          controller: _telNumCtr,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            labelText: 'Telephone No.',
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: TextField(
                                          controller: _cityCtr,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            labelText: 'City',
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Flexible(
                                      child: TextField(
                                          controller: _barangayCtr,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            labelText: 'Barangay',
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Flexible(
                                      child: TextField(
                                          controller: _zipcodeCtr,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            labelText: 'Zipcode',
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 6, 15, 6),
                                child: TextField(
                                  controller: _noteCtr,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Note',
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                child: ValueListenableBuilder(
                                    valueListenable: _isLoadingNotifier,
                                    builder: (context, _isLoading, _) {
                                      return ElevatedButton(
                                        child: const Text("CREATE"),
                                        onPressed: (_isLoading == true)
                                            ? null
                                            : () async {
                                                _isLoadingNotifier.value = true;
                                                await CustomerService()
                                                    .addCustomer(
                                                        _firstNameCtr.text,
                                                        _middleNameCtr.text,
                                                        _lastNameCtr.text,
                                                        _zipcodeCtr.text,
                                                        _barangayCtr.text,
                                                        _cityCtr.text,
                                                        _celNumCtr.text,
                                                        _telNumCtr.text,
                                                        _noteCtr.text,
                                                        "Hot",
                                                        1,
                                                        const Color(0xFFD3231E)
                                                            .toString());
                                                _isLoadingNotifier.value =
                                                    false;
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
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
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    },
    child: const Icon(
      Icons.add_circle_outline,
      size: 26.0,
    ),
    backgroundColor: const Color(0xFFF1A22C),
  );
}
