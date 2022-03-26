import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 185, 17, 5),
      child: const Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 65.0,
        ),
      ),
    );
  }
}
