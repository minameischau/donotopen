import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:panow/models/auth_token.dart';
import 'package:panow/models/order_item.dart';
import 'package:panow/services/order_service.dart';
import 'package:flutter/foundation.dart';
import 'package:panow/models/cart_item.dart';

class OrdersManager with ChangeNotifier {
  List<OrderItem> _items = [];

  final OrderService _orderService;

  OrdersManager([AuthToken? authToken])
      : _orderService = OrderService(authToken);

  set authToken(AuthToken? authToken) {
    _orderService.authToken = authToken;
  }

  Future<void> fetchOrders([bool filterByUser = false]) async {
    _items = await _orderService.fetchOrders(filterByUser);
    notifyListeners();
  }

  Future<void> addOrder(OrderItem orderItem) async {
    final newOrder = await _orderService.addOrder(orderItem);
    if (newOrder != null) {
      _items.add(newOrder);
      notifyListeners();
    }
  }

  Future<void> deleteOrder(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    OrderItem? existingorder = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _orderService.deleteOrder(id)) {
      _items.insert(index, existingorder);
      notifyListeners();
    }
  }

  int get orderCount {
    return _items.length;
  }

  List<OrderItem> get items {
    return [..._items];
  }

  OrderItem? findById(String id) {
    try {
      return _items.firstWhere((element) => element.id == id);
    } catch (error) {
      return null;
    }
  }
}
