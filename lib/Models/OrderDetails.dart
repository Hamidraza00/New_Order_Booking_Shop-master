

import 'package:order_booking_shop/Views/OrderBookingPage.dart';

class OrderDetails {
  final String orderId;
  //final Product product;
  final int quantity;
  final String productId;
  final String productName;
  final String uom;
  final String price;


  OrderDetails({required this.quantity, required this. orderId, required this.productId, required this.productName, required this.uom, required this.price});

  Map<String, dynamic> toMap() {
    return {
    'orderId': orderId,
     'productId': productId,
      'productName': productName,

      'quantity': quantity,
      //'productName': productName,
     'uom': uom,
      'price': price,
    };
  }
}