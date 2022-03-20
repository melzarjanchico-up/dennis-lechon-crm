// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// firestore test shiz
import '../../services/test_database.dart';

class CustomerScreen extends StatelessWidget {

  final Stream<QuerySnapshot> tags = FirebaseFirestore.instance.collection('tags').snapshots();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "route",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF1A22C),
          title: const Text("Customer List"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              const Text(
                "Hello!", 
                style: TextStyle(color: Colors.black)
              ),

              Container(
                height: 250,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: 
                  StreamBuilder<QuerySnapshot>(
                    stream: tags, 
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Something went wrong!");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Loading.");
                      }

                      final data = snapshot.requireData;
                      return ListView.builder(
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          return Text('this is my sample tag ${data.docs[index]['name']}.');
                        }
                      );
                    }
                  ),
              ),

              RaisedButton(
                child: const Text("Back"),
                color: const Color(0xFFF1A22C),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
