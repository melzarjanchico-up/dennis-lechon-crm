import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/services/firebase_database_services.dart';
import 'package:provider/provider.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/customer_list.dart';
import 'package:dennis_lechon_crm/widgets/search.dart';
import 'package:flutter/services.dart';
import 'package:validators/validators.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    // Stream Builder
    return StreamBuilder<List<Customer>>(
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
                  // Somethings wrong here po.
                  // Another exception was thrown: Incorrect use of ParentDataWidget.
                  floatingActionButton:
                      floatingAddCustomerButton(context, _formKey),
                  body: StreamProvider<List<Customer>>.value(
                    value:
                        CustomerService().customers, // as in wala koy mabuhat
                    initialData: const [],
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 45.0),
                        child: const CustomerListWidget()),
                  ),
                  //body: Container(
                  //  value: CustomerService().customers,
                  //  initialData: const [],
                  //  child: Container(
                  //    margin: const EdgeInsets.only(bottom: 45.0),
                  //    child: CustomerListWidget(snapshotx: snapshot)
                  //    ),
                  //),
                );
            }
          } else {
            return const Center(
              child: Text("Something went wrong. Please contact admin."),
            );
          }
        });
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
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
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
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
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
                          right: 3.0,
                          top: 5.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const CircleAvatar(
                              radius: 17,
                              backgroundColor: Color.fromARGB(255, 173, 23, 18),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 23.0,
                              ),
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
                                    const EdgeInsets.fromLTRB(15, 55, 15, 6),
                                child: TextFormField(
                                  controller: _firstNameCtr,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    labelText: 'First Name',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().isEmpty) {
                                      return "This field cannot be blank.";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 6),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(2),
                                  ],
                                  controller: _middleNameCtr,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    labelText: 'Middle Initial',
                                  ),
                                  validator: (value) {
                                    if (!(isUppercase(value![0])) ||
                                        value[1] != '.') {
                                      return "Invalid Middle Initial.";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 6),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _lastNameCtr,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    labelText: 'Last Name',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().isEmpty) {
                                      return "This field cannot be blank.";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 6, 15, 6),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(11),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  controller: _celNumCtr,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    labelText: 'Cellphone No.',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().isEmpty) {
                                      return "This field cannot be blank.";
                                    }
                                    if (value.length != 11 &&
                                        value[0] != '0' &&
                                        value[1] != '9') {
                                      return "Invalid cellphone number.";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 6, 15, 6),
                                child: TextField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(' '),
                                    ],
                                    controller: _barangayCtr,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      labelText: 'Address',
                                    )),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 6, 15, 6),
                                child: TextFormField(
                                  controller: _noteCtr,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Notes',
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
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  _isLoadingNotifier.value =
                                                      true;
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
                                                          const Color(
                                                                  0xFFD3231E)
                                                              .toString());
                                                  _isLoadingNotifier.value =
                                                      false;
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
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
                                      );
                                    }),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Positioned(
                                bottom: 50.0,
                                right: 0.0,
                                child: Container(
                                  width: double.infinity,
                                  height: 20,
                                  alignment: Alignment.bottomCenter,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFD3231E),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25),
                                    ),
                                  ),
                                ),
                              ),
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
      Icons.add,
      size: 26.0,
    ),
    backgroundColor: const Color(0xFFF1A22C),
  );
}
