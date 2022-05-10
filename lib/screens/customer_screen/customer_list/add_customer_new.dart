//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/models/tags.dart';
import 'package:dennis_lechon_crm/services/customer_database_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum TagState { hot, warm, cold }

int calculateAge(DateTime birthDate) {
  var from = birthDate;
  var to = DateTime.now();
  return ((to.difference(from).inHours / 24) / 365).floor();
}

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  TagState? _tagChoice;
  final _formKey = GlobalKey<FormState>();

  // Controllers.
  DateTime? _birthdateController;
  int? _ageController;
  Tag? _tagController;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _celNumController = TextEditingController();
  final TextEditingController _telNumController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _barangayController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tagChoice = TagState.hot;
    _tagController =
        const Tag(name: "Hot", tagColor: Color(0xFFD3231E), index: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD3231E),
        title: Text('Add Customer',
            style: GoogleFonts.oxygen(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // ----------------------------------------------- //
              // CUSTOMER DETAILS BELOW E.G NAME, CONTACT, B-DAY //
              // ----------------------------------------------- //
              const Icon(
                Icons.person,
                color: Colors.black54,
                size: 50.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                          labelText: 'First Name',
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0)),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: TextFormField(
                      controller: _middleNameController,
                      decoration: const InputDecoration(
                          labelText: 'Middle Name',
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0)),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                          labelText: 'Last Name',
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0)),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: TextFormField(
                      controller: _celNumController,
                      decoration: const InputDecoration(
                          labelText: 'Cellphone Number',
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0)),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      controller: _telNumController,
                      decoration: const InputDecoration(
                          labelText: 'Telephone Number',
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0)),
                    ),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: const Text(
                          'Birthdate:',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        )),
                    TextButton.icon(
                      onPressed: () async {
                        await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now(),
                                initialEntryMode: DatePickerEntryMode.input)
                            .then((value) {
                          setState(() {
                            _birthdateController = value;
                            _ageController = calculateAge(value!);
                          });
                        }).onError((error, stackTrace) => null);
                      },
                      icon: const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.black87,
                      ),
                      label: Text(
                        (_birthdateController != null)
                            ? '${_birthdateController!.month}/${_birthdateController!.day}/${_birthdateController!.year}'
                            : 'Select',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                        ),
                      ),
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 10.0),
                          minimumSize: Size.zero,
                          backgroundColor: Colors.black12),
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                            const Text(
                              'Age:',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              (_ageController != null)
                                  ? '$_ageController y/o'
                                  : 'N/A',
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),

              const SizedBox(
                height: 25.0,
              ),

              // ---------------------- //
              // CUSTOMER ADDRESS BELOW //
              // ---------------------- //
              const Icon(
                Icons.public,
                color: Colors.black54,
                size: 50.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _streetController,
                      decoration: const InputDecoration(
                          labelText: 'Building/Street/Block No.',
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0)),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: TextFormField(
                      controller: _barangayController,
                      decoration: const InputDecoration(
                          labelText: 'District/Barangay',
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0)),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cityController,
                      decoration: const InputDecoration(
                          labelText: 'Municipality/City',
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0)),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: TextFormField(
                      controller: _provinceController,
                      decoration: const InputDecoration(
                          labelText: 'Province',
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0)),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: TextFormField(
                      controller: _zipcodeController,
                      decoration: const InputDecoration(
                          labelText: 'Zipcode',
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0)),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 25.0,
              ),

              // ----------------------- //
              // CUSTOMER APP INFO BELOW //
              // ----------------------- //
              const Icon(
                Icons.notes,
                color: Colors.black54,
                size: 50.0,
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _noteController,
                      decoration: const InputDecoration(
                          labelText: 'Notes',
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0)),
                      maxLines: null,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: const Text(
                          'Tags:',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        )),
                    selectableTag(TagState.hot, const Color(0xFFD3231E), "Hot"),
                    selectableTag(
                        TagState.warm, const Color(0xFFF1A22C), "Warm"),
                    selectableTag(
                        TagState.cold, const Color(0xFF2A87BB), "Cold"),
                  ],
                ),
              ),

              const SizedBox(
                height: 10.0,
              ),

              // --------------- //
              // CUSTOMER BUTTON //
              // --------------- //
              Flex(direction: Axis.horizontal, children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await CustomerService()
                          .addCustomer(
                              _firstNameController.text,
                              _middleNameController.text,
                              _lastNameController.text,
                              _streetController.text,
                              _barangayController.text,
                              _cityController.text,
                              _zipcodeController.text,
                              _provinceController.text,
                              _celNumController.text,
                              _telNumController.text,
                              _birthdateController,
                              _noteController.text,
                              _tagController)
                          .then((value) {
                        debugPrint("Customer Added successfully!");
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Customer was added successfully!')));
                      }).onError((error, stackTrace) {
                        debugPrint("I did something bad... $error");
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Somewthing went wrong. Customer was not added.')));
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Create Customer",
                        style: GoogleFonts.oxygen(),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFD3231E),
                      onPrimary: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ),
              ])
            ]),
          ),
        ),
      ),
    );
  }

  Widget selectableTag(TagState tagState, Color tagColor, String tagName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _tagChoice = tagState;
          _tagController = Tag(
              index: (tagState.index) + 1, tagColor: tagColor, name: tagName);
        });
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: (_tagChoice == tagState) ? tagColor : Colors.black45,
            ),
            child: Text(
              tagName,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
