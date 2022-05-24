class Order {
  // essential info
  final String id;
  final String customerId;

  // customer name
  final String firstName;
  final String lastName;

  // customer deets
  final String contact;
  final String address;

  // general order info
  final DateTime dateAdded;
  final DateTime dateDelivery;
  final bool isRush;
  final bool isDelivery;
  final String orderPaymentStatus;

  // number-related order info
  final int smallLechonCount;
  final int mediumLechonCount;
  final int largeLechonCount;
  final int extraLargeLechonCount;
  final int deliveryFee;

  const Order({
    required this.id,
    required this.customerId,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.contact,
    required this.dateAdded,
    required this.dateDelivery,
    required this.isRush,
    required this.isDelivery,
    required this.orderPaymentStatus,
    required this.smallLechonCount,
    required this.mediumLechonCount,
    required this.largeLechonCount,
    required this.extraLargeLechonCount,
    required this.deliveryFee,
  });
}
