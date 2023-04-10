import 'dart:math';

import 'package:flutter/material.dart';
import 'package:panow/ui/home/home_product_grid_tile.dart';
import 'package:provider/provider.dart';

import 'package:panow/models/product.dart';
import 'package:panow/ui/control_screen.dart';

class AllProductGrid extends StatefulWidget {

  const AllProductGrid({super.key});

  @override
  State<AllProductGrid> createState() => _AllProductGridState();
}

class _AllProductGridState extends State<AllProductGrid> {
  List<String> categories = ['Keyboard', 'Mouse', 'Headphone'];
  // final num_type = 3;

  @override
  Widget build(BuildContext context) {
    final products = context.read<ProductsManager>().getListProducts();
    // Đọc ra List<Product> sẽ được hiển thị từ ProductsManager
    // final products = context.select<ProductsManager, List<Product>>(
    //     (productsManager) => showFavorites
    //         ? productsManager.favoriteItems
    //         : productsManager.items);
    return ListView.builder(
      // padding: const EdgeInsets.all(10.0),
      // physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: categories.length,
      itemBuilder: (ctx, i){
        List<Product> listOfCate = context.read<ProductsManager>().getListProductsByType(categories[i]);
        
        return Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BigText(
                      text: categories[i],
                      size: 18,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.chevron_right,
                        color: primaryCorlor,
                      ),
                    )
                  ],
                ),
              )
            ),
            ListView.builder(
              
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: listOfCate.length,
              itemBuilder: (ctx, index) => HomeProductGridTile(listOfCate[index])
                // for(var e in products) {
                //   bool test = ctx.read<ProductsManager>().isExistInList(listOfCate, e);
                //   print(test);
                //   {if(e.type == categories[i] && !test) {
                //     listOfCate.add(e);
                //   }}
                // }
                // if(listOfCate.isNotEmpty) {
                //   return HomeProductGridTile(listOfCate[add]);
                // } else {
                //   return Container();
                // }

              // }
            )
          ],
        );
      
      },
      
    );
  }
}
