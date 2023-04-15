import 'package:flutter/material.dart';
import '../../ui/control_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../ui/widgets/big_text.dart';
import '../../ui/widgets/icon_and_text.dart';
import '../../ui/widgets/small_text.dart';
import '../../models/product.dart';

class HomeProductGridTile extends StatelessWidget {
  const HomeProductGridTile(this.product, {super.key});
  final Product product;
  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailScreen.routeName, arguments: product.id);
      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, bottom: 20),
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(10)),

              // borderRadius: BorderRadius.circular(10),
              border: Border.all(color: secondCorlor, width: 1),
              image: DecorationImage(
                  image: NetworkImage(product.imageUrl), fit: BoxFit.cover),
            ),
          ),

          Container(
            height: 120,
            width: 230,
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFe8e8e8),
                  offset: const Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
            child: Row(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  //Ten
                  BigText(
                    text: product.title,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  SmallText(
                    text: formatCurrency(product.price),
                    size: 16,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Wrap(
                        children: List.generate(
                            4,
                            (index) => Icon(
                                  Icons.star,
                                  color: primaryCorlor,
                                  size: 12,
                                )),
                      ),
                      Icon(
                        Icons.star_half,
                        color: primaryCorlor,
                        size: 12,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SmallText(text: "4.9"),

                      SizedBox(
                        width: 10,
                      ),
                      // Icon(Icons.favorite)
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  SmallText(text: "127 Comments"),
                  // SizedBox(
                  //   width: 20,
                  // ),
                  // SmallText(text: "")

                  // IconAndText(
                  //     icon: Icons.access_time_rounded,
                  //     size: 15,
                  //     text: "27 days",
                  //     iconColor: primaryCorlor)
                ]),
                ValueListenableBuilder<bool>(
                  valueListenable: product.isFavoriteListenable,
                  builder: (ctx, isFavorite, child) {
                    return Container(
                      margin: EdgeInsets.only(left: 40),
                      // padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              // Icons.favorite_outline_rounded,
                              product.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_rounded,
                              size: 35,
                              color: primaryCorlor,
                            ),
                            onPressed: () {
                              ctx
                                  .read<ProductsManager>()
                                  .toggleFavoriteStatus(product);
                            },
                          )
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),

          // Container(
          //   child: Icon(Icons.favorite),
          // )
        ],
        // ],
      ),
    );
  }
}
