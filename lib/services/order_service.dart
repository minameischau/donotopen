import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:panow/models/order_item.dart';
import 'package:panow/models/auth_token.dart';
import 'package:panow/services/firebase_service.dart';

class OrderService extends FirebaseService {
  OrderService([AuthToken? authToken]) : super(authToken);

  Future<List<OrderItem>> fetchOrders([bool filterByUser = false]) async {
    final List<OrderItem> orders = [];
    try {
      final filters =
          filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      final orderUrl =
          Uri.parse('$databaseUrl/orders.json?auth=$token&$filters');
      final response = await http.get(orderUrl);
      final ordersMap = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        print(ordersMap['error']);
        return orders;
      }
      print(response.body);
      ordersMap.forEach((orderId, order) {
        print(order);
        orders.add(
          OrderItem.fromJson({
            'id': orderId,
            ...order,
          }),
        );
      });
      return orders;
    } catch (error) {
      print(error);
      return orders;
    }
  }

  Future<OrderItem?> addOrder(OrderItem orderItem) async {
    try {
      final url = Uri.parse('$databaseUrl/orders.json?auth=$token');
      final response = await http.post(url,
          body: json.encode(orderItem.toJson()..addAll({'creatorId': userId})));
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return orderItem.copyWith(id: json.decode(response.body)['name']);
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Future<bool> deleteOrder(String id) async {
  //   try {
  //     final url = Uri.parse('$databaseUrl/orders/$id.json?auth=$token');
  //     final response = await http.delete(url);

  //     if (response.statusCode != 200) {
  //       throw Exception(json.decode(response.body)['error']);
  //     }

  //     return true;
  //   } catch (error) {
  //     print(error);
  //     return false;
  //   }
  // }
}
