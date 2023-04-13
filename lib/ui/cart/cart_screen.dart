import 'package:flutter/material.dart';
import 'package:panow/ui/orders/order_information.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:panow/ui/control_screen.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    final total = cart.totalAmount;
    ChangeNotifierProvider(create: (context) => AuthManager());
    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart'),
      ),
      drawer: const AppDrawer(),
      body: Consumer<AuthManager>(
        builder: (context, authManager, child) {
          return Material(
            child: authManager.isAuth
                ? buildPageCart(cart, total, authManager.authToken!.email)
                : LoginScreen(),
          );
        },
      ),
    );

//---------------Old Version------------------
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Your Cart'),
    //   ),
    //   body: Column(
    //     children: <Widget>[
    //       buildCartSummary(cart, context),
    //       const SizedBox(height: 10),
    //       Expanded(
    //         child: buildCartDetails(cart),
    //       )
    //     ],
    //   ),
    // );
//---------------Old Version End------------------
  }

  Widget buildPageCart(cart, total, email) {
    return Consumer<AuthManager>(
      builder: (context, authManager, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(children: [
            // AppBarCart(),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: 1000, 
                  child: buildCartDetails(cart)
                ),
              ),
            ),
            Container(
              height: 150,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    offset: Offset(5.0, 5.0),
                    blurRadius: 5.0,
                    spreadRadius: 5.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 5.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              ),
              child: buildCartSummary(cart, total, email, context),
            )
          ]),
        );
      },
    );
  }

  Widget buildCartDetails(CartManager cart) {
    return ListView(
        children: cart.productEntries
            .map((e) => CardItemCard(productId: e.key, cardItem: e.value))
            .toList());
  }

  // Widget buildCartSummaryOld(CartManager cart, BuildContext context) {
  //   return Card(
  //     margin: const EdgeInsets.all(15),
  //     child: Padding(
  //       padding: const EdgeInsets.all(8),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: <Widget>[
  //           const Text(
  //             'Total',
  //             style: TextStyle(fontSize: 20),
  //           ),
  //           const Spacer(),
  //           Chip(
  //             label: Text(
  //               '\$${cart.totalAmount.toStringAsFixed(2)}',
  //               style: TextStyle(
  //                 color: Theme.of(context).primaryTextTheme.titleLarge?.color,
  //               ),
  //             ),
  //             backgroundColor: Theme.of(context).primaryColor,
  //           ),
  //           // TextButton(
  //           //   onPressed: cart.totalAmount <= 0
  //           //       ? null
  //           //       : () {
  //           //           context.read<OrdersManager>().addOrder(
  //           //                 cart.products,
  //           //                 cart.totalAmount,
  //           //               );
  //           //           cart.clear();
  //           //         },
  //           //   style: TextButton.styleFrom(
  //           //     textStyle: TextStyle(color: Theme.of(context).primaryColor),
  //           //   ),
  //           //   child: const Text('ORDER NOW'),
  //           // )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget buildCartSummary(CartManager cart, total, email, BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 25, bottom: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallText(
                      text: "Voucher",
                      size: 15,
                    ),
                    SmallText(
                      text: "Áp dụng mã giảm giá",
                      size: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Tổng cộng',
                    style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 135, 135, 135),
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    formatCurrency(total),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              TextButton(
                child: Text(
                  'Đặt hàng',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: cart.totalAmount <= 0
                    ? null
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderInformation(cart.products, cart.totalAmount, email)
                                // OrderInfo(
                                //     cart.products, cart.totalAmount, email  )
                                ));

                        // context
                        //     .read<OrdersManager>()
                        //     .addOrder(cart.products);
                        // cart.clear();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => OrderScreen()));
                      },
                style: TextButton.styleFrom(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 15, left: 50, right: 50),
                    foregroundColor: Colors.white,
                    elevation: 20,
                    backgroundColor: primaryCorlor),
              ),
            ],
          ),
        )
      ],
    );
  }
}
