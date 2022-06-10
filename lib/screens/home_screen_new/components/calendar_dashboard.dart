import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:dennis_lechon_crm/screens/homebuttons/events.dart';
import 'package:dennis_lechon_crm/screens/order_screen/order_info/order_info_new.dart';
import 'package:dennis_lechon_crm/services/calendar_database_services.dart';
import 'package:dennis_lechon_crm/widgets/loading.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDash extends StatefulWidget {
  final FirebaseFirestore firestore;
  const CalendarDash({Key? key, required this.firestore}) : super(key: key);

  @override
  State<CalendarDash> createState() => _CalendarDashState();
}

class _CalendarDashState extends State<CalendarDash> {
  final headFormat = DateFormat("MMM dd, yyyy");
  final format = DateFormat("dd MMM yyyy, h:mm a");
  late ValueNotifier<List<Event>> _selectedEvents;
  //CalendarFormat _calendarFormat = CalendarFormat.week;
  //RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.disabled; // Can be toggled on/off by longpressing a date
  //DateTime _focusedDay = DateTime.now();
  //DateTime? _selectedDay;
  //DateTime? _rangeStart;
  //DateTime? _rangeEnd;
  
  var kEvents = {};
  
  @override
  void initState() {
    super.initState();
    _selectedEvents = ValueNotifier(_getEventsForDay(DateTime.now()));
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

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<Event>>(
      stream: CalendarService(firestore: widget.firestore).events,
      builder: (context, snapshot) {

        if (snapshot.hasData) {
        final Map<DateTime, List<Event>> _kEventSource = {};

        for (var event in (snapshot.data)!) { 
          _kEventSource[DateTime(event.date.year, event.date.month, event.date.day)] = 
          _kEventSource[DateTime(event.date.year, event.date.month, event.date.day)] != null 
          ? [...?_kEventSource[DateTime(event.date.year, event.date.month, event.date.day)], event] : 
          [event];
        }
        
        kEvents = LinkedHashMap<DateTime, List<Event>>(
          equals: isSameDay,
          hashCode: getHashCode,
        )..addAll(_kEventSource);

        _selectedEvents = ValueNotifier(_getEventsForDay(DateTime.now()));

        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 3,
          margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: [

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4.0),
                    child: Text(
                      'Today\'s Events (${headFormat.format(DateTime.now())})',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                      textAlign: TextAlign.left
                    ),
                  ),
                ),

                Flexible(
                  child: ValueListenableBuilder<List<Event>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return value.isEmpty ? 
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Center(
                            child: Text("No events for today!")
                          ),
                        ) :
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return OrderInfo(order: value[index].order, firestore: widget.firestore);
                                });
                              },
                              title: Text('${value[index]}'),
                              subtitle: Text(
                                format.format(value[index].date),  
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
        );

        }

        return const ClearLoading();

      }
    );

  }
}

/*
class CalendarDash extends StatelessWidget {
  final FirebaseFirestore firestore;
  const CalendarDash({Key? key, required this.firestore}) : super(key: key);

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
*/
