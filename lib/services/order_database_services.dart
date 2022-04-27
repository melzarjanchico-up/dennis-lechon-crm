// this is a testing for the firestore capabilities hehe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/models/order.dart';

class OrderService {
  final Query<Map<String, dynamic>> orderCollection =
      FirebaseFirestore.instance.collectionGroup('orders');

  // Add Order Data
  // Future addOrder(
  //     String deliveryDate,
  //     double deliveryFee,
  //     bool deliveryType,
  //     bool ifPaid,
  //     double subPrice,
  //     double totalPrice,
  //     double smallLechon,
  //     double mediumLechon,
  //     double largeLechon,
  //     double extraLargeLechon) async {
  //   return await orderCollection.doc().set({
  //     'delivery_date': deliveryDate,
  //     'delivery_type': deliveryType,
  //     'delivery_fee': deliveryFee,
  //     'ifPaid': ifPaid,
  //     'sub_price': subPrice,
  //     'total_price': totalPrice,
  //     'items': {
  //       'smallLechon': smallLechon,
  //       'mediumLechon': mediumLechon,
  //       'largeLechon': largeLechon,
  //       'extrLargeLechon': extraLargeLechon
  //     },
  //   });
  // }

  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      var preId = doc.id;
      var customerId = (doc.data() as Map)['customerID'] ?? '';
      var predeliveryDate = (doc.data() as Map)['delivery_date'] ?? '';
      var predeliveryType = (doc.data() as Map)['delivery_type'] ?? '';
      var predeliveryFee = (doc.data() as Map)['delivery_fee'] ?? '';
      var preifPaid = (doc.data() as Map)['ifPaid'] ?? '';
      var presubPrice = (doc.data() as Map)['sub_price'] ?? '';
      var pretotalPrice = (doc.data() as Map)['total_price'] ?? '';
      var presmallLechon = (doc.data() as Map)['items']['small_WL'] ?? '';
      var premediumLechon = (doc.data() as Map)['items']['medium_WL'] ?? '';
      var prelargeLechon = (doc.data() as Map)['items']['large_WL'] ?? '';
      var preextraLargeLechon =
          (doc.data() as Map)['items']['extra_large_WL'] ?? '';

      return Order(
        id: preId,
        deliveryDate: predeliveryDate,
        customerid: customerId,
        deliveryFee: predeliveryFee,
        deliveryType: predeliveryType,
        ifPaid: preifPaid,
        subPrice: presubPrice,
        totalPrice: pretotalPrice,
        smallLechon: presmallLechon,
        mediumLechon: premediumLechon,
        largeLechon: prelargeLechon,
        extraLargeLechon: preextraLargeLechon,
      );
    }).toList();
  }

  // Search snapshots to be converted to a list of customers
  Stream<List<Order>>? get orders {
    return orderCollection.snapshots().map(_orderListFromSnapshot);
  }

  Stream<List<Order>> makeStream(List<Order> list) async* {
    yield list;
  }
}
