import 'package:flutter/material.dart';
import '../../ui/control_screen.dart';
import 'package:provider/provider.dart';

import '../../ui/widgets/big_text.dart';
import '../../ui/widgets/icon_and_text.dart';
import '../../ui/widgets/small_text.dart';
import '../../models/product.dart';

class HomeProductGridTile extends StatelessWidget  {
  const HomeProductGridTile (this.product, {super.key});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailScreen.routeName, arguments: product.id);
      },
      child: Container(
        child: Row(
          children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, bottom: 20),
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(product.imageUrl),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    height: 120,
                    width: 230,
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(10)),
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                            text: product.title,
                            size: 15,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          SmallText(text: product.type),
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              Wrap(
                                children: List.generate(
                                    5,
                                    (index) => Icon(
                                          Icons.star,
                                          color: primaryCorlor,
                                          size: 12,
                                        )),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SmallText(text: "4.5"),
                              SizedBox(
                                width: 10,
                              ),
                              SmallText(text: "127"),
                              SizedBox(
                                width: 10,
                              ),
                              SmallText(text: "Comments")
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          IconAndText(
                              icon: Icons.access_time_rounded,
                              size: 15,
                              text: "27 days",
                              iconColor: primaryCorlor)
                        ]),
                  )
                ],
          // ],
        ),
      ),
    );
  }
}