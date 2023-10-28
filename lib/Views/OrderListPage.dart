// import 'package:flutter/material.dart';
// import '../Databases/DBHelperOrder.dart';
// import '../Databases/OrderDatabase.dart';
// import 'OrderConfirmationPage.dart';
//
// class OrderListPage extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order List'),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: OrderDatabase.instance.getOrders(), // Use the method to get all orders
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData && snapshot.data != null) {
//               final orders = snapshot.data!;
//               return ListView.builder(
//                 itemCount: orders.length,
//                 itemBuilder: (context, index) {
//                   final order = orders[index];
//                   return ListTile(
//                     title: Text('Order #${order["id"]}'), // Display order number
//                     subtitle: Text('Shop Name: ${order["shopName"]}'),
//                     onTap: () {
//                       _navigateToOrderConfirmation(context, order);
//                     },
//                   );
//                 },
//               );
//             } else {
//               return Center(child: Text('No orders found.'));
//             }
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
//
//   void _navigateToOrderConfirmation(BuildContext context, Map<String, dynamic> orderData) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => OrderConfirmationPage(orderData),
//       ),
//     );
//   }
// }
