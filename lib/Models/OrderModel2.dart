class Order {
  String shopName;
  String ownerName;
  String phoneNumber;
  String brand;
  List<OrderItem> items;

  Order({
    required this.shopName,
    required this.ownerName,
    required this.phoneNumber,
    required this.brand,
    required this.items,
  });
}

class OrderItem {
  String itemName;
  int quantity;
  double rate;
  double amount;

  OrderItem({
    required this.itemName,
    required this.quantity,
    required this.rate,
    required this.amount,
  });
}
