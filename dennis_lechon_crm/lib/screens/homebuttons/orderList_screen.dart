// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "route",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFD3231E),
          title: Text("Order List"),
        ),
        body: Center(
          child: RaisedButton(
            child: Text("Back"),
            color: Color(0xFFD3231E),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
