import 'package:panow/models/cart_item.dart';

class OrderItem {
  final String? id;
  final double amount;
  final List<CartItem> products;
  final String name;
  final String phone;
  final String email;
  final String address;
  final DateTime dateTime;

  int get productCount {
    return products.length;
  }

  OrderItem({
    this.id,
    required this.amount,
    required this.products,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    DateTime? dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  OrderItem copyWith({
    String? id,
    double? amount,
    List<CartItem>? products,
    String? name,
    String? phone,
    String? email,
    String? address,
    DateTime? dateTime,
  }) {
    return OrderItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      products: products ?? this.products,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'products': List<dynamic>.from(products.map((x) => x.toJson())),
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  static OrderItem fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      amount: json['amount'],
      products: List<CartItem>.from(
          json["products"].map((x) => CartItem.fromJson(x))),
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      dateTime: DateTime.parse(json["dateTime"]),
    );
  }
}
