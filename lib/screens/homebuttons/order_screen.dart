// ignore_for_file: deprecated_member_use, file_names
//import 'package:dennis_lechon_crm/widgets/loading.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "route",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFD3231E),
          title: const Text("Order List"),
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
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            GestureDetector(
              onTap: () {
                // sa customer list ni siya na code po huehue
                //Navigator.push(
                //    context,
                //     MaterialPageRoute(
                //         builder: (context) => CustomerInfo(customer: customer)));
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Order No. 69",
                                          // ignore: prefer_const_constructors
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text("Melzar Boang",
                                          style: TextStyle(
                                              color: Colors.grey[500])),
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
                            const Text('To be delivered on: 10/13/2022',
                                style: TextStyle(color: Colors.grey)),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.green),
                              child: const Text(
                                "Active",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ])
                    ],
                  ),
                ),
              ),
            ),
          ],
          /* This is the back button, gi comment lang sa nako kay wa ko 
              kabaw asa ni e butang
           RaisedButton(
            child: const Text("Back"),
            color: const Color(0xFFD3231E),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          */
        ),
      ),
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
