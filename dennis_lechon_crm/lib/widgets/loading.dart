import 'package:dennis_lechon_crm/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: hexStringToColor("D3231E"),
      child: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 65.0,
        ),
      ),
    );
  }
}
