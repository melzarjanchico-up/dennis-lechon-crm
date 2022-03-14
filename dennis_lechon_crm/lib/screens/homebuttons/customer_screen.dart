// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "route",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF1A22C),
          title: Text("Customer List"),
        ),
        body: Center(
          child: RaisedButton(
            child: Text("Back"),
            color: Color(0xFFF1A22C),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
