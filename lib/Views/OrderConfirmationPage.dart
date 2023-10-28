// import 'package:flutter/material.dart';
//
// import '../Databases/OrderDatabase.dart';
//
// class OrderConfirmationPage extends StatelessWidget {
//   final int orderId;
//
//   OrderConfirmationPage(this.orderId);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Confirmation'),
//       ),
//       body: FutureBuilder<Map<String, dynamic>?>(
//         future: OrderDatabase.instance.getOrder(orderId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData && snapshot.data != null) {
//               final orderData = snapshot.data!;
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text('Order Booking Confirmation:'),
//                     SizedBox(height: 20),
//                     Text('Shop Name: ${orderData["shopName"]}'),
//                     Text('Owner Name: ${orderData["ownerName"]}'),
//                     Text('Phone#: ${orderData["phone"]}'),
//                     Text('Brand: ${orderData["brand"]}'),
//                     Text('Item 1: ${orderData["item1"]}'),
//                     Text('Item 2: ${orderData["item2"]}'),
//                     Text('Item 3: ${orderData["item3"]}'),
//                     Text('Item 4: ${orderData["item4"]}'),
//                   ],
//                 ),
//               );
//             } else {
//               return Center(child: Text('Order not found.'));
//             }
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       )
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../Databases/OrderDatabase.dart';

class OrderConfirmationPage extends StatelessWidget {
  final Map<String, dynamic> orderData;

  OrderConfirmationPage(this.orderData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Order Booking Confirmation:'),
            SizedBox(height: 20),
            Text('Shop Name: ${orderData["shopName"]}'),
            Text('Owner Name: ${orderData["ownerName"]}'),
            Text('Phone#: ${orderData["phone"]}'),
            Text('Brand: ${orderData["brand"]}'),
            Text('Item 1: ${orderData["item1"]}'),
            Text('Item 2: ${orderData["item2"]}'),
            Text('Item 3: ${orderData["item3"]}'),
            Text('Item 4: ${orderData["item4"]}'),
          ],
        ),
      ),
    );
  }
}

