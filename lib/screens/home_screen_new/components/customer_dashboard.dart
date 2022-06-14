import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:dennis_lechon_crm/services/customer_database_services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:dennis_lechon_crm/widgets/indicator.dart';
import 'package:dennis_lechon_crm/widgets/loading.dart';

class CustomerDash extends StatefulWidget {
  const CustomerDash({Key? key, required this.firestore}) : super(key: key);
  final FirebaseFirestore firestore;

  @override
  State<StatefulWidget> createState() => _CustomerDashState();
}

class _CustomerDashState extends State<CustomerDash> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: StreamBuilder<List<Customer>>(
            stream: CustomerService(firestore: widget.firestore)
                .customers
                ?.asBroadcastStream(onCancel: (sub) => sub.cancel()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                int hotCount = snapshot.data!
                    .where((element) => element.tagName.contains("Hot"))
                    .map((e) => e)
                    .toList()
                    .length;
                int warmCount = snapshot.data!
                    .where((element) => element.tagName.contains("Warm"))
                    .map((e) => e)
                    .toList()
                    .length;
                int coldCount = snapshot.data!
                    .where((element) => element.tagName.contains("Cold"))
                    .map((e) => e)
                    .toList()
                    .length;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Center(
                        child: Text("Offline. Try again later."));
                  case ConnectionState.waiting:
                    return const ClearLoading();
                  default:
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 35),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const Text(
                                  "You have ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                Text(
                                  snapshot.data!.length.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              "customers!",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            const SizedBox(height: 15),
                            Indicator(
                              color: const Color(0xFFD3231E),
                              text: "Hot",
                              isSquare: false,
                              total: hotCount,
                            ),
                            const SizedBox(height: 10),
                            Indicator(
                              color: const Color(0xFFF1A22C),
                              text: "Warm",
                              isSquare: false,
                              total: warmCount,
                            ),
                            const SizedBox(height: 10),
                            Indicator(
                              color: const Color(0xFF2A87BB),
                              text: "Cold",
                              isSquare: false,
                              total: coldCount,
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
                                          pieTouchResponse.touchedSection ==
                                              null) {
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
                                  sections: showingSections(
                                      hotCount, warmCount, coldCount)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    );
                }
              }
              return const ClearLoading();
            }),
      ),
    );
  }

  List<PieChartSectionData> showingSections(
      int hotCount, int warmCount, int coldCount) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 80.0 : 75.0;
      final widgetSize = isTouched ? 35.0 : 30.0;
      var total = hotCount + warmCount + coldCount;
      var hot = (hotCount / total) * 100;
      var warm = (warmCount / total) * 100;
      var cold = (coldCount / total) * 100;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xFFD3231E),
            value: hot,
            title: "${hot.toStringAsPrecision(2)}%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(Icons.local_fire_department,
                size: widgetSize,
                borderColor: const Color(0xFFD3231E),
                iconColor: const Color(0xFFD3231E)),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xFFF1A22C),
            value: warm,
            title: "${warm.toStringAsPrecision(2)}%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              Icons.air_outlined,
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
              iconColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xFF2A87BB),
            value: cold,
            title: "${cold.toStringAsPrecision(2)} %",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              Icons.ac_unit_outlined,
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
  final IconData icons;
  final double size;
  final Color borderColor;
  final Color iconColor;

  const _Badge(
    this.icons, {
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
      child: FittedBox(
        fit: BoxFit.fill,
        child: Icon(
          icons,
          color: iconColor,
        ),
      ),
    );
  }
}
