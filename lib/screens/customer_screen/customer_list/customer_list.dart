import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_info/customer_info.dart';

class CustomerListWidget extends StatefulWidget {
  const CustomerListWidget({
    Key? key,
    /*, required this.snapshotx*/
  }) : super(key: key);
  //final AsyncSnapshot<List<Customer>> snapshotx;

  @override
  State<CustomerListWidget> createState() => _CustomerListWidgetState();
}

class _CustomerListWidgetState extends State<CustomerListWidget> {
  @override
  Widget build(BuildContext context) {
    final customers = Provider.of<List<Customer>>(context);
    // final customers = widget.snapshotx.data!;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: customers.map((customer) {
        
        String lastName = customer.lastName;
        String firstName = customer.firstName;
        String tagName = customer.tagName;
        String address = '${customer.adrBarangay}, ${customer.adrCity} ${customer.adrZipcode}';
        Color tagColor = customer.tagColor;

        return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerInfo(customer: customer)));
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(children: [
                            Flexible(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('$firstName $lastName',
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(address,
                                        style:
                                            TextStyle(color: Colors.grey[500])),
                                  ]),
                            )
                          ]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: tagColor),
                            child: Text(
                              tagName,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const Text('Incoming Order')
                        ])
                  ],
                ),
              ),
            ));
      }).toList(),
    );
  }
}
