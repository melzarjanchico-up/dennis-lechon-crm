// this is a testing for the firestore capabilities hehe
//import 'dart:collection';

import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:dennis_lechon_crm/models/order.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/events.dart';
import 'package:dennis_lechon_crm/services/customer_database_services.dart';
import 'package:dennis_lechon_crm/services/order_database_services.dart';
import 'dart:async';


class CalendarService {
  CalendarService({required this.firestore});
  final FirebaseFirestore firestore;
  final Query<Map<String, dynamic>> orderCollection = FirebaseFirestore.instance.collectionGroup('orders');
  CollectionReference get customerCollection => firestore.collection('customers');

  List<Event> _orderListFromSnapshot(QuerySnapshot snapshot) {
    List<Event> test = snapshot.docs.map((doc) {
      String preFirstName = (doc.data() as Map)['customer']['first_name'];
      String preLastName = (doc.data() as Map)['customer']['last_name'];
      String preDateDelivery = (doc.data() as Map)['delivery_date'];
    
      return Event(
        title: '$preFirstName $preLastName',
        date: DateTime.parse(preDateDelivery),
        order: OrderService(firestore: firestore).orderConverter(doc),
        type: 'order'
      );
    }).toList();

    test.sort((a,b) => a.date.compareTo(b.date));
    return test;
  }

  List<Event> _customerListFromSnapshot(QuerySnapshot snapshot) {
    List<Event> test = snapshot.docs.map((doc) {

      String? preFirstName = (doc.data() as Map)['first_name'];
      String? preLastName = (doc.data() as Map)['last_name'];
      String? preDateBirth = (doc.data() as Map)['birth_date'];

      DateTime raw = (preDateBirth != null) ? (DateTime.tryParse(preDateBirth) != null ? DateTime.parse(preDateBirth) : DateTime(0)) : DateTime(0);
      if (raw != DateTime(0)) {
        raw = DateTime(2022, raw.month, raw.day);
        if (raw.isBefore(DateTime.now())) {
          raw = DateTime(2023, raw.month, raw.day);
        }
      }

      return Event(
        title: '$preFirstName $preLastName',
        date: raw,
        customer: CustomerService(firestore: firestore).customerConverter(doc),
        type: 'customer'
      );

    }).toList();

    test.retainWhere((element) => element.date != DateTime(0));
    test.sort((a,b) => a.date.compareTo(b.date));

    
    return test;
  }

  // Search snapshots to be converted to a list of customers
  Stream<List<List<Event>>>? get events {
    Stream<List<Event>> huhu = customerCollection.snapshots().map(_customerListFromSnapshot);
    Stream<List<Event>> hihi = orderCollection.snapshots().map(_orderListFromSnapshot);

    return StreamZip([huhu, hihi]);
  }

  Stream<List<Event>> makeStream(List<Event> list) async* {
    yield list;
  }

}