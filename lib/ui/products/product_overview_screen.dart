import 'package:flutter/material.dart';
import 'package:panow/ui/products/all_product_agrid.dart';
import 'package:panow/ui/products/all_product_grid.dart';
// import 'package:panow/ui/products/all_product_grid.dart';
import 'package:provider/provider.dart';

import 'package:panow/ui/control_screen.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);
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
        title: const Center(
          child: Text(
            "Products",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: <Widget>[
          buildProductFilterMenu(),
          buildSearchIcon(),
          buildShoppingCartIcon(),
        ],
      ),
      // drawer: const AppDrawer(),
      body: FutureBuilder(
          // print(listProducts);
          future: _fetchProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ValueListenableBuilder<bool>(
                  valueListenable: _showOnlyFavorites,
                  builder: (context, onlyFavorites, child) {
                    if (_showOnlyFavorites.value) {
                      return AllProductAGrid(onlyFavorites);
                    } else {
                      return AllProductGrid();
                    }
                  });
              // return const AllProductGrid();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(
      builder: (ctx, cartManager, child) {
        final cart = context.watch<CartManager>();
        final total = cart.productCount;
        return TopRightBadge(
          data: total,
          child: IconButton(
            icon: const Icon(
              Icons.shopping_cart_rounded,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        );
      },
    );
  }
  
  Widget buildSearchIcon() {
    return IconButton(
      icon: const Icon(Icons.search_rounded),
      onPressed: () {
        Navigator.of(context).pushNamed(
          SearchScreen.routeName,
        );
      },
    );
  }

  Widget buildProductFilterMenu() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        if (selectedValue == FilterOptions.favorites) {
          _showOnlyFavorites.value = true;
        } else {
          _showOnlyFavorites.value = false;
        }
      },
      icon: const Icon(
        Icons.more_vert_rounded,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text("Only Favorites"),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text("Show All"),
        ),
      ],
    );
  }
}
