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

  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      margin: const EdgeInsets.all(10),
      // color: blue,
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: min(widget.order.productCount * 20.0 + 10, 100),
      child: ListView(
        children: widget.order.products
            .map(
              (prod) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    prod.title,
                    style: const TextStyle(fontSize: 16, color: textCorlor
                        // fontWeight: FontWeight.bold,
                        ),
                  ),
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: '${prod.quantity}x ',
                        style: const TextStyle(
                          fontSize: 16,
                          color: textCorlor,
                          fontFamily: 'SFCompactRounded',
                        ),
                      ),
                      TextSpan(
                        text: '${formatCurrency(prod.price)} ',
                        style: const TextStyle(
                          fontSize: 16,
                          color: red,
                          fontFamily: 'SFCompactRounded',
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildOrderSummary() {
    return Material(
      elevation: 3,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.account_circle_rounded,
            ),
            title: const Text(
              'Orderer\'s name',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                widget.order.name,
                style: const TextStyle(
                  fontSize: 18,
                ),
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
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                widget.order.email,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.phone_enabled_rounded),
            title: const Text(
              'Phone number',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                widget.order.phone,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.date_range_rounded),
            title: const Text(
              'Date',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.location_on_rounded),
            title: const Text(
              'Address',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                widget.order.address,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  formatCurrency(widget.order.amount),
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
      ),
    );
  }
}
