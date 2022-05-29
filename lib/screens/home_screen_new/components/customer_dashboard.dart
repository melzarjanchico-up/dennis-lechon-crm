import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dennis_lechon_crm/widgets/indicator.dart';

class CustomerDash extends StatefulWidget {
  const CustomerDash({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomerDashState();
}

class CustomerDashState extends State {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 35),
            Column(
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Text(
                      "You have ",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                    ),
                    Text(
                      "100",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "customers!",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                ),
                const SizedBox(height: 15),
                const Indicator(
                  color: Color(0xFFD3231E),
                  text: "Hot",
                  isSquare: false,
                  total: 40,
                ),
                const SizedBox(height: 10),
                const Indicator(
                  color: Color(0xFFF1A22C),
                  text: "Warm",
                  isSquare: false,
                  total: 40,
                ),
                const SizedBox(height: 10),
                const Indicator(
                  color: Color(0xFF2A87BB),
                  text: "Cold",
                  isSquare: false,
                  total: 30,
                ),
                const SizedBox(height: 20),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AspectRatio(
                aspectRatio: 2,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback:
                          (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 5,
                      centerSpaceRadius: 0,
                      sections: showingSections()),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xFFD3231E),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge('assets/svgs/hot.svg',
                size: widgetSize,
                borderColor: const Color(0xFFD3231E),
                iconColor: const Color(0xFFD3231E)),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xFFF1A22C),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'svgs/warm.svg',
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
              iconColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xFF2A87BB),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'svgs/cold.svg',
              size: widgetSize,
              borderColor: const Color(0xFF2A87BB),
              iconColor: const Color(0xFF2A87BB),
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw 'None.';
      }
    });
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;
  final Color iconColor;

  const _Badge(
    this.svgAsset, {
    Key? key,
    required this.size,
    required this.borderColor,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: SvgPicture.asset(
          svgAsset,
          color: iconColor,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

// =================== ANOTHA ONE ======================

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:dennis_lechon_crm/widgets/indicator.dart';
// import 'package:dennis_lechon_crm/widgets/color_extensions.dart';

// class CustomerDash extends StatefulWidget {
//   const CustomerDash({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => CustomerDashState();
// }

// class CustomerDashState extends State {
//   int touchedIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.3,
//       child: Card(
//         color: Colors.white,
//         child: Column(
//           children: <Widget>[
//             const SizedBox(
//               height: 28,
//             ),
//             Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 Indicator(
//                   color: const Color(0xff0293ee),
//                   text: 'One',
//                   isSquare: false,
//                   size: touchedIndex == 0 ? 18 : 16,
//                   textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
//                 ),
//                 Indicator(
//                   color: const Color(0xfff8b250),
//                   text: 'Two',
//                   isSquare: false,
//                   size: touchedIndex == 1 ? 18 : 16,
//                   textColor: touchedIndex == 1 ? Colors.black : Colors.grey,
//                 ),
//                 Indicator(
//                   color: const Color(0xff845bef),
//                   text: 'Three',
//                   isSquare: false,
//                   size: touchedIndex == 2 ? 18 : 16,
//                   textColor: touchedIndex == 2 ? Colors.black : Colors.grey,
//                 ),
//                 Indicator(
//                   color: const Color(0xff13d38e),
//                   text: 'Four',
//                   isSquare: false,
//                   size: touchedIndex == 3 ? 18 : 16,
//                   textColor: touchedIndex == 3 ? Colors.black : Colors.grey,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 18,
//             ),
//             Expanded(
//               child: AspectRatio(
//                 aspectRatio: 1,
//                 child: PieChart(
//                   PieChartData(
//                       pieTouchData: PieTouchData(touchCallback:
//                           (FlTouchEvent event, pieTouchResponse) {
//                         setState(() {
//                           if (!event.isInterestedForInteractions ||
//                               pieTouchResponse == null ||
//                               pieTouchResponse.touchedSection == null) {
//                             touchedIndex = -1;
//                             return;
//                           }
//                           touchedIndex = pieTouchResponse
//                               .touchedSection!.touchedSectionIndex;
//                         });
//                       }),
//                       startDegreeOffset: 180,
//                       borderData: FlBorderData(
//                         show: false,
//                       ),
//                       sectionsSpace: 1,
//                       centerSpaceRadius: 0,
//                       sections: showingSections()),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<PieChartSectionData> showingSections() {
//     return List.generate(
//       4,
//       (i) {
//         final isTouched = i == touchedIndex;
//         final opacity = isTouched ? 1.0 : 0.6;

//         const color0 = Color(0xff0293ee);
//         const color1 = Color(0xfff8b250);
//         const color2 = Color(0xff845bef);
//         const color3 = Color(0xff13d38e);

//         switch (i) {
//           case 0:
//             return PieChartSectionData(
//               color: color0.withOpacity(opacity),
//               value: 25,
//               title: '',
//               radius: 80,
//               titleStyle: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xff044d7c)),
//               titlePositionPercentageOffset: 0.55,
//               borderSide: isTouched
//                   ? BorderSide(color: color0.darken(40), width: 6)
//                   : BorderSide(color: color0.withOpacity(0)),
//             );
//           case 1:
//             return PieChartSectionData(
//               color: color1.withOpacity(opacity),
//               value: 25,
//               title: '',
//               radius: 65,
//               titleStyle: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xff90672d)),
//               titlePositionPercentageOffset: 0.55,
//               borderSide: isTouched
//                   ? BorderSide(color: color1.darken(40), width: 6)
//                   : BorderSide(color: color2.withOpacity(0)),
//             );
//           case 2:
//             return PieChartSectionData(
//               color: color2.withOpacity(opacity),
//               value: 25,
//               title: '',
//               radius: 60,
//               titleStyle: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xff4c3788)),
//               titlePositionPercentageOffset: 0.6,
//               borderSide: isTouched
//                   ? BorderSide(color: color2.darken(40), width: 6)
//                   : BorderSide(color: color2.withOpacity(0)),
//             );
//           case 3:
//             return PieChartSectionData(
//               color: color3.withOpacity(opacity),
//               value: 25,
//               title: '',
//               radius: 70,
//               titleStyle: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xff0c7f55)),
//               titlePositionPercentageOffset: 0.55,
//               borderSide: isTouched
//                   ? BorderSide(color: color3.darken(40), width: 6)
//                   : BorderSide(color: color2.withOpacity(0)),
//             );
//           default:
//             throw Error();
//         }
//       },
//     );
//   }
// }

// =================== OLD CUSTOMER DASHBOARD CODE ===================

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dennis_lechon_crm/screens/homebuttons/customer_screen.dart';
// import 'package:flutter/material.dart';

// class CustomerDash extends StatelessWidget {
//   const CustomerDash({Key? key, required this.firestore}) : super(key: key);

//   final FirebaseFirestore firestore;
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: <Widget>[
//             CustomerCard(
//                 age: '21 years old',
//                 name: 'Maria Leonora Teresa Mamasita',
//                 address: 'Mandaue',
//                 press: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             CustomerScreen(firestore: firestore)),
//                   );
//                 }),
//             CustomerCard(
//                 age: '21 years old',
//                 name: 'Dianne',
//                 address: 'Minglanilla',
//                 press: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             CustomerScreen(firestore: firestore)),
//                   );
//                 }),
//             CustomerCard(
//                 age: '21 years old',
//                 name: 'Melzar',
//                 address: 'Lapu-lapu',
//                 press: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             CustomerScreen(firestore: firestore)),
//                   );
//                 }),
//             CustomerCard(
//                 age: '21 years old',
//                 name: 'Vorr',
//                 address: 'Banilad',
//                 press: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             CustomerScreen(firestore: firestore)),
//                   );
//                 }),
//             CustomerCard(
//                 age: '21 years old',
//                 name: 'Emma',
//                 address: 'Talamban',
//                 press: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             CustomerScreen(firestore: firestore)),
//                   );
//                 }),
//           ],
//         ));
//   }
// }

// class CustomerCard extends StatelessWidget {
//   const CustomerCard({
//     Key? key,
//     required this.age,
//     required this.name,
//     required this.address,
//     required this.press,
//   }) : super(key: key);

//   final String age, name, address;
//   final VoidCallback press;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//         margin: const EdgeInsets.only(
//           left: 20,
//           top: 10,
//           bottom: 0,
//         ),
//         width: size.width * 0.25,
//         height: size.width * 0.25,
//         //height: 100,
//         //size.width * 0.4,
//         child: Column(
//           children: <Widget>[
//             GestureDetector(
//               onTap: press,
//               child: Container(
//                 padding: const EdgeInsets.only(left: 25, right: 25),
//                 decoration: const BoxDecoration(
//                     color: Color(0xFFF1A22C),
//                     borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(20),
//                         topLeft: Radius.circular(20))),
//                 height: 32,
//                 width: size.width * 0.25,
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(name,
//                           overflow: TextOverflow.fade,
//                           maxLines: 1,
//                           softWrap: false,
//                           style: const TextStyle(
//                               fontFamily: 'Baloo_2',
//                               fontSize: 18,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold)),
//                     ]),
//               ),
//             ),
//             GestureDetector(
//               onTap: press,
//               child: Container(
//                 //color: Colors.red,
//                 padding: const EdgeInsets.all(10),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(20),
//                     bottomRight: Radius.circular(20),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       offset: Offset(0, 10),
//                       blurRadius: 20,
//                       color: Color.fromARGB(101, 158, 158, 158),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       address,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w500,
//                         color: Color(0xFF1F2426),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       age,
//                       style: const TextStyle(
//                         color: Color(0xFF1F2426),
//                       ),
//                     ),
//                     SizedBox(width: size.width * 0.25),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
// }
