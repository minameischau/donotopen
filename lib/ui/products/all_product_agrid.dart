import 'package:flutter/material.dart';
import 'package:panow/ui/home/home_product_grid_tile.dart';
import 'package:provider/provider.dart';

import 'product_grid_tile.dart';
import 'products_manager.dart';
import '../../models/product.dart';

class AllProductAGrid extends StatelessWidget {
  final bool showFavorites;

  const AllProductAGrid(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    // final productsManager = ProductsManager();
    // final products = showFavorites ? productsManager.favoriteItems : productsManager.items;
    final products = context.select<ProductsManager, List<Product>>(
      (productsManager) => showFavorites
      ? productsManager.favoriteItems
      : productsManager.items
    );
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => HomeProductGridTile(products[i])
    );
  }
}