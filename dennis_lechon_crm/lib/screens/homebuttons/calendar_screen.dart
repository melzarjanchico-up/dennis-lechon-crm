// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "route",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF2A87BB),
          title: Text("Calendar"),
        ),
        body: Center(
          child: RaisedButton(
            child: Text("Back"),
            color: Color(0xFF2A87BB),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
