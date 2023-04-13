import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:panow/models/order_item.dart';
import 'package:panow/ui/control_screen.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem order;
  const OrderItemCard(this.order, {super.key});

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          buildOrderSummary(),
          if (_expanded) buildOrderDetails()
        ],
      ),
    );
  }

  Widget buildOrderDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: min(widget.order.productCount * 20.0 + 10, 100),
      child: ListView(
        children: widget.order.products!
            .map(
              (prod) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    prod.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${prod.quantity}x \$${prod.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: grey,
                    ),
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildOrderSummary() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.account_circle_rounded),
          title: const Text(
            'Tên người đặt hàng',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            widget.order.name,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.email_rounded),
          title: const Text(
            'Email',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            widget.order.email,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.phone_enabled_rounded),
          title: const Text(
            'Số điện thoại',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            widget.order.phone,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.date_range_rounded),
          title: const Text(
            'Thời gian đặt hàng',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
          ),
        ),
        ListTile(
          title: Row(
            children: [
              const Text(
                'Địa chỉ:',
                style: TextStyle(fontSize: 18, color: grey),
              ),
              Text(
                widget.order.address,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              const Text(
                'Tổng tiền:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '${widget.order.amount}00 VNĐ',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: red),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
        ),
      ],
    );
  }
}
