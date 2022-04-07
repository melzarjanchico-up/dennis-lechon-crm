import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:flutter/material.dart';

class SearchCustomer extends SearchDelegate {
  final CollectionReference _customerSearch =
      FirebaseFirestore.instance.collection("customers");

  @override
  List<Widget> buildActions(BuildContext context) {
    //para ra ni tig clear  sa search bar if pisliton ang 'x'
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        //Somethings wrong if you click this.
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //tig balik sa customer list na page (back)
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //if naa siyay makita na match kay e sud niya diri na string
    return StreamBuilder<QuerySnapshot>(
        stream: _customerSearch.snapshots().asBroadcastStream(
            onCancel: (sub) => sub.cancel()), //to avoid data leakage
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Loading();
          } else {
            if (snapshot.data!.docs
                .where((QueryDocumentSnapshot<Object?> fields) =>
                    fields['first_name']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()) ||
                    fields['last_name']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .isEmpty) {
              return const Center(
                child: Text("I'm sorry. No customer exists."),
              );
            } else {
              return ListView(
                children: [
                  ...snapshot.data!.docs
                      .where((QueryDocumentSnapshot<Object?> fields) =>
                          fields['first_name']
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()) ||
                          fields['last_name']
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                      .map((QueryDocumentSnapshot<Object?> data) {
                    String lastName = data['last_name'];
                    String firstName = data['first_name'];
                    String tagName = data['tag']['tagname'];
                    //Frontenders here. It would be nice if we can reuse the customerlistwidget sa customer_info.dart.like import nlng para dli hasul
                    return ListTile(
                      onTap: () {},
                      title: Text(
                        "$lastName $firstName",
                        style: const TextStyle(fontSize: 15),
                      ),
                      subtitle: Text(tagName),
                    );
                  })
                ],
              );
            }
          }
        });
  }

  @override
  //same ra ni sa babaw, pero sa suggestion ni siya para char
  //maybe naa moy maadd diri po?
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text("Search Customer"));
  }
}
