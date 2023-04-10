import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_product_grid_tile.dart';
import '../../ui/products/products_manager.dart';
import '../../models/product.dart';

class HomeProductGrid extends StatelessWidget {
  // final bool showFavorites;

  const HomeProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.select<ProductsManager, List<Product>>(
      (productsManager) => false
      ? productsManager.favoriteItems
      : productsManager.items
    );
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => HomeProductGridTile(products[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
