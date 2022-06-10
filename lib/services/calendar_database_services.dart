// this is a testing for the firestore capabilities hehe
//import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:dennis_lechon_crm/models/order.dart';
import 'package:dennis_lechon_crm/screens/homebuttons/events.dart';
import 'package:dennis_lechon_crm/services/order_database_services.dart';

class CalendarService {
  CalendarService({required this.firestore});
  final FirebaseFirestore firestore;
  final Query<Map<String, dynamic>> orderCollection = FirebaseFirestore.instance.collectionGroup('orders');

  List<Event> _orderListFromSnapshot(QuerySnapshot snapshot) {
    List<Event> test = snapshot.docs.map((doc) {
      //String preId = doc.id;

      //String preCustomerId = (doc.data() as Map)['customer']['id'];
      String preFirstName = (doc.data() as Map)['customer']['first_name'];
      String preLastName = (doc.data() as Map)['customer']['last_name'];
      //String preAddress = (doc.data() as Map)['customer']['address'];
      //String preContact = (doc.data() as Map)['customer']['contact'];

      //Timestamp preDateAdded = (doc.data() as Map)['added_date'];
      String preDateDelivery = (doc.data() as Map)['delivery_date'];
      //bool preIsRush = (doc.data() as Map)['is_rush'];
      //bool preIsDelivery = (doc.data() as Map)['is_delivery'];
      //String prePaymentStatus = (doc.data() as Map)['payment_status'];
      //int preDeliveryFee = (doc.data() as Map)['delivery_fee'];

      //int preSmallLechonCount = (doc.data() as Map)['details']['small'];
      //int preMediumLechonCount = (doc.data() as Map)['details']['medium'];
      //int preLargeLechonCount = (doc.data() as Map)['details']['large'];
      //int preXLargeLechonCount = (doc.data() as Map)['details']['xlarge'];
    
      return Event(
        title: '$preFirstName $preLastName',
        date: DateTime.parse(preDateDelivery),
        order: OrderService(firestore: firestore).orderConverter(doc)
      );
    }).toList();

    test.sort((a,b) => a.date.compareTo(b.date));
    return test;
  }

  // Search snapshots to be converted to a list of customers
  Stream<List<Event>>? get events {
    return orderCollection.snapshots().map(_orderListFromSnapshot);
  }

  Stream<List<Event>> makeStream(List<Event> list) async* {
    yield list;
  }

  Future<List<Event>> eventsMap() async {
    List<Event> test = await events!.firstWhere((element) => true);
    return test;
  }

}