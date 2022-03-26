import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 185, 17, 5),
      child: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 65.0,
        ),
      ),
    );
  }
}
