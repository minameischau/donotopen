import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:panow/models/order_item.dart';
import 'package:panow/ui/control_screen.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // late Future<void> _fetchOrders;

  @override
  void initState() {
    super.initState();
    // _fetchOrders = context.read<OrdersManager>().fetchOrders();
  }

  // @override
  final ordersManager = OrdersManager();

  @override
  Widget build(BuildContext context) {
    context.select<OrdersManager, List<OrderItem>>(
        (ordersManager) => ordersManager.items);
    ChangeNotifierProvider(create: (context) => AuthManager());
    return Consumer<AuthManager>(builder: (context, authManager, child) {
      return Scaffold(
          body: Column(
        children: [
          AppBarOrigin(
            leading: IconButton(
              color: textCorlor,
              icon: const Icon(Icons.arrow_back, size: 20.0),
              onPressed: () {
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => WelcomeScreen()));
              },
            ),
            title: 'Đơn đặt hàng',
            action: IconButton(
              color: textCorlor,
              icon: const Icon(Icons.home_rounded, size: 20.0),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Consumer<OrdersManager>(
                builder: (context, ordersManager, child) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: ordersManager.orderCount,
                    itemBuilder: (ctx, i) {
                      if (authManager.authToken!.email ==
                          ordersManager.items[i].email) {
                        return OrderItemCard(ordersManager.items[i]);
                      } else if (authManager.authToken!.email ==
                              'admin@gmail.com' ||
                          authManager.authToken!.email == 'panow@gmail.com') {
                        return OrderItemCard(ordersManager.items[i]);
                      }
                      return const Text(
                        'Đơn đặt hàng trống',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ));
    });
  }
}