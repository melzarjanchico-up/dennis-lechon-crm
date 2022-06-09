// this is a testing for the firestore capabilities hehe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dennis_lechon_crm/models/order.dart';

class OrderService {
  OrderService({required this.firestore});
  final FirebaseFirestore firestore;
  CollectionReference get customerCollection =>
      firestore.collection('customers');
  Query<Map<String, dynamic>> get orderCollection =>
      firestore.collectionGroup('orders');

  Future addOrder(
      String customerId,
      String customerFirstName,
      String customerLastName,
      String customerAddress,
      String customerContact,
      DateTime deliveryDate,
      bool isRush,
      bool isDelivery,
      String paymentStatus,
      int? deliveryFee,
      int sCount,
      int mCount,
      int lCount,
      int xlCount) async {
    return await customerCollection.doc(customerId).collection('orders').add({
      'customer': {
        'id': customerId,
        'first_name': customerFirstName,
        'last_name': customerLastName,
        'address': customerAddress,
        'contact': customerContact,
      },
      'added_date': Timestamp.now(),
      'delivery_date': deliveryDate.toString(),
      'is_rush': isRush,
      'is_delivery': isDelivery,
      'payment_status': paymentStatus,
      'delivery_fee': deliveryFee ?? 0,
      'details': {
        'small': sCount,
        'medium': mCount,
        'large': lCount,
        'xlarge': xlCount
      }
    });
  }

  Future editOrder(
      String docId,
      String customerId,
      String customerFirstName,
      String customerLastName,
      String customerAddress,
      String customerContact,
      DateTime deliveryDate,
      DateTime addedDate,
      bool isRush,
      bool isDelivery,
      String paymentStatus,
      int? deliveryFee,
      int sCount,
      int mCount,
      int lCount,
      int xlCount) async {
    return await customerCollection
        .doc(customerId)
        .collection('orders')
        .doc(docId)
        .set({
      'customer': {
        'id': customerId,
        'first_name': customerFirstName,
        'last_name': customerLastName,
        'address': customerAddress,
        'contact': customerContact,
      },
      'added_date': Timestamp.fromDate(addedDate), //change
      'delivery_date': deliveryDate.toString(),
      'is_rush': isRush,
      'is_delivery': isDelivery,
      'payment_status': paymentStatus,
      'delivery_fee': deliveryFee ?? 0,
      'details': {
        'small': sCount,
        'medium': mCount,
        'large': lCount,
        'xlarge': xlCount
      }
    });
  }

  Future deleteOrder(String customerId, String orderId) async {
    return await customerCollection
        .doc(customerId)
        .collection('orders')
        .doc(orderId)
        .delete();
  }

  Order orderConverter(doc) {
    String preId = doc.id;

    String preCustomerId = (doc.data() as Map)['customer']['id'];
    String preFirstName = (doc.data() as Map)['customer']['first_name'];
    String preLastName = (doc.data() as Map)['customer']['last_name'];
    String preAddress = (doc.data() as Map)['customer']['address'];
    String preContact = (doc.data() as Map)['customer']['contact'];

    Timestamp preDateAdded = (doc.data() as Map)['added_date'];
    String preDateDelivery = (doc.data() as Map)['delivery_date'];
    bool preIsRush = (doc.data() as Map)['is_rush'];
    bool preIsDelivery = (doc.data() as Map)['is_delivery'];
    String prePaymentStatus = (doc.data() as Map)['payment_status'];
    int preDeliveryFee = (doc.data() as Map)['delivery_fee'];

    int preSmallLechonCount = (doc.data() as Map)['details']['small'];
    int preMediumLechonCount = (doc.data() as Map)['details']['medium'];
    int preLargeLechonCount = (doc.data() as Map)['details']['large'];
    int preXLargeLechonCount = (doc.data() as Map)['details']['xlarge'];
  
    return Order(
      id: preId,
      customerId: preCustomerId,
      firstName: preFirstName,
      lastName: preLastName,
      address: preAddress,
      contact: preContact,
      dateAdded: preDateAdded.toDate(),
      dateDelivery: DateTime.parse(preDateDelivery),
      isRush: preIsRush,
      isDelivery: preIsDelivery,
      orderPaymentStatus: prePaymentStatus,
      deliveryFee: preDeliveryFee,
      smallLechonCount: preSmallLechonCount,
      mediumLechonCount: preMediumLechonCount,
      largeLechonCount: preLargeLechonCount,
      extraLargeLechonCount: preXLargeLechonCount,
    );
  }

  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    List<Order> test = snapshot.docs.map((doc) {
      return orderConverter(doc);
    }).toList();

    test.sort((a, b) => a.dateDelivery.compareTo(b.dateDelivery));
    return test;
  }

  // Search snapshots to be converted to a list of customers
  Stream<List<Order>>? get orders {
    return orderCollection.snapshots().map(_orderListFromSnapshot);
  }

  Stream<List<Order>>? customerOrders(String customerId) {
    return customerCollection
        .doc(customerId)
        .collection('orders')
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  Stream<List<Order>> makeStream(List<Order> list) async* {
    yield list;
  }
}
