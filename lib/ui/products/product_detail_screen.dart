import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:panow/models/product.dart';
import 'package:panow/ui/control_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';
  final Product product;
  const ProductDetailScreen(
    this.product, {
    super.key,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _n = 1;
  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n > 1) _n--;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(product.title),
    //   ),
    //   body: SingleChildScrollView(
    //     child: Column(
    //       children: <Widget>[
    //         SizedBox(
    //           height: 300,
    //           width: double.infinity,
    //           child: Image.network(
    //             product.imageUrl,
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //         const SizedBox(height: 10),
    //         Text(
    //           '\$${product.price}',
    //           style: const TextStyle(
    //             color: Colors.grey,
    //             fontSize: 20,
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Container(
    //           padding: const EdgeInsets.symmetric(horizontal: 10),
    //           width: double.infinity,
    //           child: Text(
    //             product.description,
    //             textAlign: TextAlign.center,
    //             softWrap: true,
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          //Image product
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.product.imageUrl),
                ),
              ),
            ),
          ),

          //Arrow back + Cart
          Positioned(
            top: 60,
            left: 3,
            right: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const AppIcon(icon: Icons.arrow_back),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                        // builder: (context) => HomeScreen()
                      ),
                    );
                  },
                  child: AppIcon(icon: Icons.shopping_cart_outlined),
                ),
              ],
            ),
          ),

          //Description
          Positioned(
            left: 0,
            right: 0,
            top: 330,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.product.title,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          )),
                      Text(
                        widget.product.price.toString() + "00 VNĐ",
                        style: const TextStyle(
                          fontSize: 20,
                          color: red,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Wrap(
                        spacing: 3,
                        children: List.generate(5, (index) {
                          return const Icon(Icons.star, color: amber, size: 20);
                        }),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        '5',
                        style: TextStyle(color: blueGrey),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        '|',
                        style: TextStyle(color: blueGrey),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Đã bán',
                        style: TextStyle(color: blueGrey),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        '234',
                        style: TextStyle(color: blueGrey),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.delivery_dining_rounded,
                                size: 20,
                                color: red,
                              ),
                            ),
                            TextSpan(
                              text: '\t\tGiao hàng miễn phí',
                              style: TextStyle(color: black26),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.gpp_good,
                                size: 20,
                                color: red,
                              ),
                            ),
                            TextSpan(
                              text: '\t\tChính hãng',
                              style: TextStyle(color: black26),
                            ),
                          ],
                        ),
                      ),
                      // RichText(
                      //     text: TextSpan(children: [
                      //   WidgetSpan(
                      //     child: Icon(
                      //       Icons.timer,
                      //       size: 20,
                      //       color: Colors.red,
                      //     ),
                      //   ),
                      //   TextSpan(
                      //       text: '\t\t30 phút',
                      //       style: TextStyle(color: Colors.black26)),
                      // ]))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mô tả',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        widget.product.description,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    width: 35,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 245, 244, 244),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // minus();
                      },
                      child: const Icon(
                        Icons.remove,
                        color: black,
                        size: 20,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      '$_n',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 17),
                    ),
                  ),
                  Container(
                    width: 35,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 245, 244, 244),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        add();
                      },
                      child: const Icon(Icons.add, color: black, size: 18),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 30, right: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: deepOrange),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      final cart = context.read<CartManager>();
                      // cart.addItem(widget.product, _n);
                      cart.addItem(widget.product);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'THÊM VÀO GIỎ HÀNG',
                      style: TextStyle(
                        fontSize: 14,
                        color: white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
