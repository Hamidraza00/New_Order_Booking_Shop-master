import 'package:order_booking_shop/Models/ProductsModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'dart:io' as io;

import '../Models/OrderDetails.dart';
import '../Models/OrderMaster.dart';



class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'order_database.db');

    return await openDatabase(path, version: 1, onCreate: _createTables);
  }

  void _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE OrderMaster (
        orderId TEXT PRIMARY KEY,
        shopName TEXT,
        ownerName TEXT,
        phoneNo TEXT,
        brand TEXT
      )
    ''');

    await db.execute('''
    CREATE TABLE OrderDetails (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      orderId TEXT,
      product_code TEXT
      quantity INTEGER,
      product_name TEXT,
      uom TEXT,
      price TEXT,
      FOREIGN KEY (orderId) REFERENCES OrderMaster(orderId)
    )
  ''');

    await db.execute(
        "CREATE TABLE products(product_code TEXT, product_name TEXT, uom TEXT ,price TEXT)"
    );
  }


Future<void> insertOrderMaster(OrderMaster orderMaster) async {
  final db = await DatabaseHelper().database;
  await db.insert('OrderMaster', orderMaster.toMap());
}

Future<void> insertOrderDetails(OrderDetails orderDetails) async {
  final db = await DatabaseHelper().database;
  await db.insert('OrderDetails', orderDetails.toMap());
}

Future<List<OrderMaster>?> getOrders() async {
  final db = await DatabaseHelper().database;
  final masterResults = await db.query('OrderMaster');
  final detailsResults = await db.query('OrderDetails');

  // Create a map of order ID to order details
  final detailsMap = <String, List<OrderDetails>>{};
  for (var row in detailsResults) {
    final detail = OrderDetails(

      quantity: (row['quantity'] as int?) ?? 0,
      orderId: '',
      productId: '',
      productName: '',
      uom: '',
      price: '',
    );

    final orderId = row['orderId'] as String; // Cast to String
    if (!detailsMap.containsKey(orderId)) {
      detailsMap[orderId] = [];
    }
    detailsMap[orderId]!.add(detail);
  }

  // Create OrderMaster instances with associated order details
  final orders = masterResults.map((row) {
    final orderId = row['orderId'] as String; // Cast to String
    return OrderMaster(
      orderId: orderId,
      shopName: row['shopName'] as String,
      ownerName: row['ownerName'] as String,
      phoneNo: row['phoneNo'] as String,
      brand: row['brand'] as String,
      orderDetails: detailsMap[orderId] ?? [],
    );
  }).toList();

  return orders;
}

Future<Object> getrow() async {
  final db = await DatabaseHelper().database;
  {
    await db.rawQuery(
        "SELECT * FROM products LIMIT 5");
    return true;
  }

    }
  Future<bool> enterproducts(Products product) async {
    final db = await DatabaseHelper().database;
    {
      await db.rawInsert(
        "INSERT INTO products (product_code, product_name, uom, price) VALUES (?, ?, ?, ?)",
        [product.product_code, product.product_name, product.uom, product.price],
      );
      return true;
    }
  }

  }





