import 'package:flutter/material.dart';
import 'package:panow/ui/products/all_product_agrid.dart';
import 'package:panow/ui/products/all_product_grid.dart';
import 'package:provider/provider.dart';

import 'package:panow/ui/control_screen.dart';

enum FilterOptions { favorites, all }

class FavoriteProductsScreen extends StatefulWidget {
  const FavoriteProductsScreen({super.key});

  @override
  State<FavoriteProductsScreen> createState() => _FavoriteProductsScreenState();
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(true);
  late Future<void> _fetchProducts;

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
    var listProducts =
        context.read<ProductsManager>().getListProductsByType('Headphone');
    // print(listProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded, size: 28.0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Favorites Product",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
          future: _fetchProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ValueListenableBuilder<bool>(
                  valueListenable: _showOnlyFavorites,
                  builder: (context, onlyFavorites, child) {
                    return AllProductAGrid(_showOnlyFavorites.value);
                  });
              // builder: (context, onlyFavorites, child) {
              //   if (_showOnlyFavorites.value) {
              //     return AllProductAGrid(onlyFavorites);
              //   } else {
              //     return AllProductGrid();
              //   }
              // });
              // return const AllProductGrid();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
