import 'package:flutter/material.dart';
import 'package:panow/ui/home/home_product_grid_tile.dart';
import 'package:provider/provider.dart';

// import 'product_grid_tile.dart';
import '../../ui/control_screen.dart';
import '../../models/product.dart';

class SearchResult extends StatelessWidget {
  final String searchText;

  const SearchResult(this.searchText, {super.key});

  @override
  Widget build(BuildContext context) {
    // final productsManager = ProductsManager();
    // final products = searchText ? productsManager.favoriteItems : productsManager.items;
    // final products = context.read<ProductsManager, List<Product>>()
    //               .searchProduct(searchText);
    var listProducts =
        context.read<ProductsManager>().searchProduct(searchText);
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10.0),
      itemCount: listProducts.length,
      itemBuilder: (ctx, i) => HomeProductGridTile(listProducts[i])
    );
    // return Text("data");
  }
}