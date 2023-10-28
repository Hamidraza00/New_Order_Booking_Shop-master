class OrderModel{
  int? id;
  String? ShopName;
  String? OwnerName;
  String? PhoneNo;
  String? Brand;
  String? Item1;
  String? Item2;
  String? Item3;
  String? Item4;


  OrderModel({this.id,this.ShopName,this.OwnerName,this.PhoneNo,this.Brand, this.Item1, this.Item2, this.Item3, this.Item4});

  factory OrderModel.fromMap(Map<dynamic,dynamic> json){
    return OrderModel(

        id: json['id'],
        ShopName: json['Shop Name'],
        OwnerName:json['Owner Name'],
        PhoneNo: json['Phone No'],
        Brand: json['Brand'],
       // ItemDescription: json['Items Description'],
        Item1: json['Item1'],
        Item2: json['Item2'],
        Item3: json['Item3'],
        Item4: json['Item4'],
    );
  }

  get shopName => null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Shop Name': ShopName,
      'Owner Name': OwnerName,
      'Phone No': PhoneNo,
      'Brand': Brand,
      // 'Items Description': ItemDescription,
      'Item1': Item1,
      'Item2': Item2,
      'Item3': Item3,
      'Item4': Item4,


    };
  }
}