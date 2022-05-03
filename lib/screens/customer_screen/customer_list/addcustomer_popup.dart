/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:dennis_lechon_crm/services/customer_database_services.dart';
import 'package:dennis_lechon_crm/models/tags.dart';
//import 'package:dennis_lechon_crm/services/tag_database_services.dart';


class AddCustomerPopup extends StatefulWidget {
  const AddCustomerPopup({ Key? key, required this.formKey }) : super(key: key);
  final GlobalKey<FormState> formKey;

  @override
  State<AddCustomerPopup> createState() => _AddCustomerPopupState();
}

ValueNotifier _isLoadingNotifier = ValueNotifier(false);

class _AddCustomerPopupState extends State<AddCustomerPopup> {
  
  final TextEditingController _firstNameCtr = TextEditingController();
  final TextEditingController _lastNameCtr = TextEditingController();
  final TextEditingController _middleNameCtr = TextEditingController();
  final TextEditingController _celNumCtr = TextEditingController();
  final TextEditingController _telNumCtr = TextEditingController();
  final TextEditingController _cityCtr = TextEditingController();
  final TextEditingController _barangayCtr = TextEditingController();
  final TextEditingController _zipcodeCtr = TextEditingController();
  final TextEditingController _noteCtr = TextEditingController();

  List<Tag> tagList = <Tag>[
    const Tag(name: 'Hot', tagColor: Color(0xFFD3231E), index: 1),
    const Tag(name: 'Warm', tagColor: Color(0xFFF1A22C), index: 1),
    const Tag(name: 'Cold', tagColor: Color(0xFF2A87BB), index: 3)
  ];
  late Tag dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = tagList[0];
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _firstNameCtr.dispose();
    _lastNameCtr.dispose();
    _middleNameCtr.dispose();
    _celNumCtr.dispose();
    _telNumCtr.dispose();
    _cityCtr.dispose();
    _barangayCtr.dispose();
    _zipcodeCtr.dispose();
    _noteCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
                      _firstNameCtr.clear();
                      _lastNameCtr.clear();
                      _celNumCtr.clear();
                      _barangayCtr.clear();
                      _noteCtr.clear();
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
                  key: widget.formKey,
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

                      //const SizedBox(
                      //  width: 20.0,
                      //),

                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(15, 6, 15, 6),
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

                      //const SizedBox(
                      //  width: 20.0,
                      //),

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

                      //const SizedBox(
                      //  width: 20.0,
                      //),

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

                      //const SizedBox(
                      //  width: 20.0,
                      //),

                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(15, 6, 15, 6),
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text('Tag'),
                              )
                            ),
                            Expanded(
                              flex: 8,
                              child: DropdownButton<Tag>(
                                value: dropdownValue,
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_downward),
                                enableFeedback: true,
                                
                                onChanged: (Tag? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },

                                items: tagList.map<DropdownMenuItem<Tag>>((Tag value) {
                                  return DropdownMenuItem<Tag>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 15),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12), 
                                            color: value.tagColor),
                                        child: Text(
                                          value.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),

                              ),
                            ),
                          ],
                        )
                      ),

                      //const SizedBox(
                      //  width: 20.0,
                      //),

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
                                        if (widget.formKey.currentState!.validate()) {
                                          //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data is in processing.')));  
                                          _isLoadingNotifier.value = true;
                                          /*
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
                                                  dropdownValue.name,
                                                  dropdownValue.index,
                                                  dropdownValue.tagColor.toString());*/
                                          _isLoadingNotifier.value = false;
                                          Navigator.of(context, rootNavigator: true).pop();
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

                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 25,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                color: Color(0xFFD3231E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
*/