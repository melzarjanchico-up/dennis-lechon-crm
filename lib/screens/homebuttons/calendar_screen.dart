import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/screens/customer_screen/customer_info/customer_info.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/events.dart';
import 'package:dennis_lechon_crm/screens/order_screen/order_info/order_info_new.dart';
import 'package:dennis_lechon_crm/services/calendar_database_services.dart';
import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  final FirebaseFirestore firestore;
  const CalendarScreen({Key? key, required this.firestore}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final headFormat = DateFormat("EEE - MMMM dd, yyyy");
  final orderFormat = DateFormat("dd MMM yyyy, h:mm a");
  final birthdayFormat = DateFormat("dd MMM yyyy");
  late ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .disabled; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  var kEvents = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.disabled;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  //comment here!
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<List<Event>>>(
        stream: CalendarService(firestore: widget.firestore).events,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Map<DateTime, List<Event>> _kEventSource = {};

            for (var listStream in (snapshot.data)!) {
              for (var event in listStream) {
                _kEventSource[DateTime(event.date.year, event.date.month,
                    event.date.day)] = _kEventSource[DateTime(event.date.year,
                            event.date.month, event.date.day)] !=
                        null
                    ? [
                        ...?_kEventSource[DateTime(
                            event.date.year, event.date.month, event.date.day)],
                        event
                      ]
                    : [event];
              }
            }

            kEvents = LinkedHashMap<DateTime, List<Event>>(
              equals: isSameDay,
              hashCode: getHashCode,
            )..addAll(_kEventSource);

            _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

            return Scaffold(
              appBar: AppBar(
                title: const Text('Your Calendar'),
                centerTitle: true,
                backgroundColor: const Color(0xFFD3231E),
              ),
              body: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 3,
                margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Column(
                    children: [
                      TableCalendar<Event>(
                        firstDay: kFirstDay,
                        lastDay: kLastDay,
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        rangeStartDay: _rangeStart,
                        rangeEndDay: _rangeEnd,
                        calendarFormat: _calendarFormat,
                        rangeSelectionMode: _rangeSelectionMode,
                        eventLoader: _getEventsForDay,
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        headerStyle: const HeaderStyle(
                          titleTextStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          formatButtonDecoration: BoxDecoration(
                              color: Color(0xFF2A87BB),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          formatButtonTextStyle: TextStyle(color: Colors.white),
                          leftChevronMargin: EdgeInsets.all(0),
                          rightChevronMargin: EdgeInsets.all(0),
                        ),
                        calendarStyle: const CalendarStyle(
                            outsideDaysVisible: false,
                            todayDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF2A87BB)),
                            selectedDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFF1A22C)),
                            markerDecoration: BoxDecoration(
                                color: Color.fromARGB(255, 116, 231, 71),
                                shape: BoxShape.circle)),
                        onDaySelected: _onDaySelected,
                        onRangeSelected: _onRangeSelected,
                        onFormatChanged: (format) {
                          if (_calendarFormat != format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 4.0),
                          child: Text(
                              _selectedDay != null
                                  ? headFormat.format(_selectedDay!)
                                  : headFormat.format(DateTime.now()),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w900),
                              textAlign: TextAlign.left),
                        ),
                      ),
                      Expanded(
                        child: ValueListenableBuilder<List<Event>>(
                          valueListenable: _selectedEvents,
                          builder: (context, value, _) {
                            return value.isEmpty
                                ? const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: Center(
                                        child: Text("No events for this day!")),
                                  )
                                : ListView.builder(
                                    itemCount: value.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 12.0,
                                          vertical: 4.0,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            switch (value[index].type) {
                                              case "customer":
                                                {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return CustomerInfo(
                                                            customer:
                                                                value[index]
                                                                    .customer!,
                                                            firestore: widget
                                                                .firestore);
                                                      }).then(
                                                        (value) => _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!)));
                                                }
                                                break;

                                              case "order":
                                                {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return OrderInfo(
                                                            order: value[index]
                                                                .order!,
                                                            firestore: widget
                                                                .firestore);
                                                      }).then((value) => _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!)));
                                                }
                                                break;
                                            }
                                          },
                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2.5),
                                            child: Text(
                                              (value[index].type == 'order')
                                                  ? '${value[index]}\'s Order'
                                                  : '${value[index]}\'s Birthday',
                                              style: const TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 16.0),
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                          subtitle: Row(
                                            children: [
                                              Icon(
                                                (value[index].type == 'order')
                                                    ? Icons
                                                        .shopping_cart_outlined
                                                    : Icons
                                                        .celebration_outlined,
                                                color: Colors.black87,
                                                size: 16.0,
                                              ),
                                              const SizedBox(
                                                width: 3.0,
                                              ),
                                              Text((value[index].type ==
                                                      'order')
                                                  ? orderFormat
                                                      .format(value[index].date)
                                                  : birthdayFormat.format(
                                                      value[index].date)),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return const Loading();
        });
  }
}
