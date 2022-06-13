//import 'dart:collection';
//import 'package:dennis_lechon_crm/services/calendar_database_services.dart';
//import 'package:table_calendar/table_calendar.dart';

import 'package:dennis_lechon_crm/models/order.dart';
import 'package:dennis_lechon_crm/models/customer.dart';

/// Example event class.
class Event {
  final String title;
  final DateTime date;
  final Order? order;
  final Customer? customer;
  final String type;
  final String? orderStatus;

  const Event({
    required this.title, 
    required this.date,
    this.order,
    this.customer,
    required this.type,
    this.orderStatus
  });

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.

/*
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

/*
Map<DateTime, List<Event>> _kEventSource = {
  for (var item in List.generate(50, (index) => index)) 
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
        item % 4 + 1, (index) => Event(title: 'Order# $item | ${index + 1}'))
};/*..addAll({
    DateTime.utc(kToday.year, kToday.month, 11): [
      const Event(title: 'Order 1'),
      const Event(title: 'Order 2'),
    ],
  });*/
*/
*/

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 12, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 12, kToday.day);
