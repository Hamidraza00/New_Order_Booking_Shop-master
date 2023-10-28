import 'package:order_booking_shop/Models/OrderDetails.dart';

class OrderMaster {
  final String orderId;
  final String shopName;
  final String ownerName;
  final String phoneNo;
  final String brand;
  final List<OrderDetails> orderDetails;

  OrderMaster({
    required this.orderId,
    required this.shopName,
    required this.ownerName,
    required this.phoneNo,
    required this.brand,
    required this.orderDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'shopName': shopName,
      'ownerName': ownerName,
      'phoneNo': phoneNo,
      'brand': brand,
      // Add other fields as needed
    };
  }
}
