import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomerDash extends StatefulWidget {
  const CustomerDash({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomerDashState();
}

class CustomerDashState extends State {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
                pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: showingSections()),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
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
            badgeWidget: _Badge(
              'https://www.svgrepo.com/svg/334718/hot',
              size: widgetSize,
              borderColor: const Color(0xFFD3231E),
            ),
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
              'https://www.svgrepo.com/svg/71601/wind',
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xFF2A87BB),
            value: 16,
            title: '16%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'https://www.svgrepo.com/svg/153280/cold',
              size: widgetSize,
              borderColor: const Color(0xFF2A87BB),
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw 'Oh no';
      }
    });
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key? key,
    required this.size,
    required this.borderColor,
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
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

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