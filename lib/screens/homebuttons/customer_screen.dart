import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/services/firebase_database_services.dart';
import 'package:provider/provider.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_list/customer_list.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    delegate: CustomSearchDelagate(),
                  );
                },
                icon: const Icon(Icons.search),
              ),
            ],
            /* code ni ni melzzar katong plus button sa top right na mu add ni ariana @emmalynboang
            actions: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () async {
                      await CustomerService().addCustomer(
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
                    },
                    child: const Icon(
                      Icons.search,
                      size: 26.0,
                    ),
                  ))
            ],
            */
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

//link sa "inspiration" na video [https://www.youtube.com/watch?v=KF1KMfQOpjM&list=LL&index=1] hehe
//diri lang mo watch para mas makasabot sa code huhu
class CustomSearchDelagate extends SearchDelegate {
  List<String> searchTerms = [
    //pre defined list para basehan sa search
    'Apple', // so sa ato na case kay ang list ni sa mga names huhu
    'Banana', // sorry i duuno how to backend
    'Pear',
    'Watermelons',
    'Oranges',
    'Blueberries',
    'Strawberries',
    'Raspberries',
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    //para ra ni tig clear  sa search bar if pisliton ang 'x'
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
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
    List<String> matchQuery = [];
    //if naa siyay makita na match kay e sud niya diri na string
    for (var fruit in searchTerms) {
      //loop para sa searching
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
        //tig display sa mga ni match
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override //same ra ni sa babaw, pero sa suggestion ni siya para char
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }
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
