import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class OrderDatabase {
  Database? _database;

  Future<void> initializeDatabase() async {
    final path = join(await getDatabasesPath(), 'orders.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // Create the 'orders' table.
        db.execute('''
          CREATE TABLE orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            shopName TEXT,
            ownerName TEXT,
            phoneNumber TEXT,
            brand TEXT
          )
        ''');
        // Create the 'orderItems' table.
        db.execute('''
          CREATE TABLE orderItems(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            orderId INTEGER,
            itemName TEXT,
            quantity INTEGER,
            rate REAL,
            amount REAL
          )
        ''');
      },
    );
  }

  Future<int> insertOrder(Map<String, dynamic> order) async {
    return await _database!.insert('orders', order);
  }

  Future<int> insertOrderItem(Map<String, dynamic> orderItem) async {
    return await _database!.insert('orderItems', orderItem);
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    return await _database!.query('orders');
  }

  Future<List<Map<String, dynamic>>> getOrderItems(int orderId) async {
    return await _database!.query('orderItems', where: 'orderId = ?', whereArgs: [orderId]);
  }
}
void initializeDatabase() async {
  final orderDatabase = OrderDatabase();
  await orderDatabase.initializeDatabase();
}
