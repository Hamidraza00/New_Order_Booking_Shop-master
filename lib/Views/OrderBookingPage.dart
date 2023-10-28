import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../Databases/OrderDatabase.dart';
import '../Models/OrderDetails.dart';
import '../Models/OrderMaster.dart';
import 'dart:io'as io;
import 'package:fluttertoast/fluttertoast.dart';

import '../Models/ProductsModel.dart';
void main() {
  runApp(MaterialApp(
    home: OrderBookingPage(),
  ));
}

class OrderBookingPage extends StatefulWidget {
  OrderBookingPage();

  @override
  _OrderBookingPageState createState() => _OrderBookingPageState();
}

class _OrderBookingPageState extends State<OrderBookingPage> {
  TextEditingController _textField1Controller = TextEditingController();
  TextEditingController _textField2Controller = TextEditingController();
  TextEditingController _textField3Controller = TextEditingController();
  TextEditingController _textField4Controller = TextEditingController();

  // List<Product> data = [];

  List<String> selectedDropdownValues = [];
  Map<String, int> itemQuantities = {};

  List<String> dropdownItems = [];
  var data;
  @override
  void initState() {
    super.initState();
    // Simulate fetching data from a dummy database

  }

  final database = DatabaseHelper();
  getdata() async {
    var response = await http.get(Uri.parse(
        'https://g04d40198f41624-i0czh1rzrnvg0r4l.adb.me-dubai-1.oraclecloudapps.com/ords/courage/product/record'));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsondata = jsonResponse['items'];

      List<Products> users = [];
      int a = 0;
      if (response.statusCode == 200) {
        for (var i in jsondata) {
          a++;
          User user = User(
              i['product_code'] as String? ??'', i['product_name']as String? ??'', i['uom'] as String? ??'', i['price']as String? ??'', id: null, name: null, uom: null, price: null);
          Products us = Products(product_code: user.id, product_name: user.name, uom: user.uom, price: user.price);
          users.add(us);
          var result = await database.enterproducts(Products(product_code: user.id, product_name: user.name, uom: user.uom, price: user.price));
          if (result == true) {
            Fluttertoast.showToast(
              // msg: "Enter ${a.toString()}", toastLength: Toast.LENGTH_SHORT);
                msg:"doneeeeeeeeeeeeeeeeeeeeee");
          } else {
            Fluttertoast.showToast(
              // msg: "Failed to Enter ${a.toString()}",
              // toastLength: Toast.LENGTH_SHORT);
                msg:"failllllllllllllllllllll");
          }
        }
      } else {
        Fluttertoast.showToast(msg: "FAIL", toastLength: Toast.LENGTH_LONG);
        data = "NOOOOOOOOOOOOO";
      }
    }
  }

  // void fetchdata() async{
  //     await database.getrow();
  //    {
  //     // [product.product_code, product.product_name, product.uom, product.price],
  //     dropdownItems.add('${prproduct_code} ${products.produ}
  //
  //    }
  // }

  // void fetchData() {
  //   // Simulate fetching data from a dummy database
  //   dummyDatabase.forEach((products) {
  //     dropdownItems.add('${product.id} ${product.name} ${product.uom} ${product.price}');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Booking'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Display the live date in the body
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Live Date: ${_getFormattedDate()}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            buildTextField('Shop Name', _textField1Controller),
            buildTextField('Owner Name', _textField2Controller),
            buildTextField('Phone No', _textField3Controller),
            buildTextField('Brand', _textField4Controller),
            buildCustomDropdown(selectedDropdownValues, dropdownItems),

            // Other widgets...

            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Button color
                ),
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedDate() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}-${now.month}-${now.year}";
    return formattedDate;
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCustomDropdown(List<String> selectedValues, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Description',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: GestureDetector(
            onTap: () {
              showDropdownList(selectedValues, dropdownItems);
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      selectedValues.isEmpty
                          ? 'Select item(s)'
                          : selectedValues.join(', '),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
        // Display text fields for selected items
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: selectedValues
              .map((item) => buildItemRow(item))
              .toList(),
        ),
      ],
    );
  }

  Widget buildItemRow(String item) {
    final quantity = itemQuantities[item] ?? 0;
    final TextEditingController quantityController =
    TextEditingController(text: quantity.toString());

    // Extract the product ID from the item string
    final productId = item.split(' ')[0];
    final screenSize = MediaQuery.of(context).size;
    final itemWidth = screenSize.width > 527
        ? screenSize.width * 0.3
        : screenSize.width * 0.4;
    final padding = 10.0;

    return Container(
      width: itemWidth,
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('ID: $productId  '),
              Expanded(
                child: Text(item, style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (quantity > 0) {
                      setState(() {
                        itemQuantities[item] = quantity - 1;
                      });
                    }
                  },
                ),
              ),
              Flexible(
                child: TextFormField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      itemQuantities[item] = int.parse(value);
                    });
                  },
                ),
              ),
              Flexible(
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      itemQuantities[item] = quantity + 1;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10), // Add spacing between items
        ],
      ),
    );
  }

  void showDropdownList(List<String> selectedValues, List<String> items) {
    final TextEditingController searchController = TextEditingController();
    final screenSize = MediaQuery.of(context).size;
    final appWidth = screenSize.width > 527 ? 527 : 307;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final filteredItems = items.where((item) {
              final query = searchController.text.toLowerCase();
              return item.toLowerCase().contains(query);
            }).toList();

            return AlertDialog(
              title: Text('Select item(s)'),
              content: Container(
                width: 1500,
                height: screenSize.height * 0.7,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for items',
                      ),
                      onChanged: (query) {
                        setState(() {});
                      },
                    ),
                    Container(
                      height: screenSize.height * 0.5,
                      child: ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(item, style: TextStyle(fontSize: 9)),
                                ),
                                Flexible(
                                  child: IconButton(
                                    icon: Icon(Icons.remove, size: 10),
                                    onPressed: () {
                                      final quantity = itemQuantities[item] ?? 0;
                                      if (quantity > 0) {
                                        setState(() {
                                          itemQuantities[item] = quantity - 1;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: TextFormField(
                                    controller:
                                    TextEditingController(text: itemQuantities[item].toString()),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        itemQuantities[item] = int.parse(value);
                                      });
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: IconButton(
                                    icon: Icon(Icons.add, size: 10),
                                    onPressed: () {
                                      final quantity = itemQuantities[item] ?? 0;
                                      setState(() {
                                        itemQuantities[item] = quantity + 1;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            trailing: TextButton(
                              onPressed: () {
                                if (selectedValues.contains(item)) {
                                  setState(() {
                                    selectedValues.remove(item);
                                  });
                                } else {
                                  setState(() {
                                    selectedValues.add(item);
                                  });
                                }
                              },
                              child: Text(selectedValues.contains(item) ? 'Remove' : 'Add'),
                              style: TextButton.styleFrom(
                                backgroundColor: selectedValues.contains(item) ? Colors.red : Colors.green,
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class User {
  final  id;
  final  name;
  final  uom;
  final  price;

  User(String s, String i, String j, String k,  {required this.id, required this.name, required this .uom, required this .price});
}

