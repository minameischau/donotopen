import 'package:panow/models/cart_item.dart';
import 'package:flutter/foundation.dart';

class OrderItem with ChangeNotifier {
  final String? id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  final String name;
  final String email;
  final String phone;
  final String address;

  int get productCount {
    return products.length;
  }

  OrderItem({
    this.id,
    required this.amount,
    required this.products,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    DateTime? dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  OrderItem copyWith({
    String? id,
    double? amount,
    List<CartItem>? products,
    DateTime? dateTime,
    String? name,
    String? email,
    String? phone,
    String? address,
  }) {
    return OrderItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      products: products ?? this.products,
      dateTime: dateTime ?? this.dateTime,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'products': products,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }

  static OrderItem fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      amount: json['amount'],
      products: json['products'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
    );
  }
}
