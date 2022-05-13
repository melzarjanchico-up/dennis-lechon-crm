import 'package:flutter/material.dart';

class CalendarDash extends StatelessWidget {
  const CalendarDash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      height: 200,
      width: size.width * 0.99,
    );
  }
}
