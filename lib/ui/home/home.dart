import 'package:flutter/material.dart';
import 'package:panow/models/product.dart';
// import 'package:panow/ui/home/home_product_grid.dart';
import 'package:panow/ui/home/home_product_grid_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import '../products/products_manager.dart';

// import 'package:panow/models/product.dart';
import 'package:panow/ui/control_screen.dart';

// enum FilterOptions { favorites, all }

class HomePageScreen extends StatefulWidget {
  static const routeName = '/homepage';

  // final OnBoards onBoard;
  // const HomePageScreen({Key? key, required this.onBoard}) : super(key: key);
  const HomePageScreen({super.key});

  // final Product product;
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<String> categories = ['Keyboard', 'Mouse', 'Headphone'];
  String category = 'Keyboard';
  int selectedPage = 0;
  // final _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;
  // late List<Product> _p;
  

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
    // _p = context.read<ProductsManager>().getListProductsByType('Headphone');
    // print(_p);
  }

  @override
  Widget build(BuildContext context) {
    // final products = context.select<ProductsManager, List>(
    //   (productsManager) => false
    //   ? productsManager.favoriteItems
    //   : productsManager.items
    // );

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Panow Tech',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: <Widget>[
          buildSearchIcon(),
          buildShoppingCartIcon(),
        ],
      ),
      // drawer: const AppDrawer(),
      body: FutureBuilder(
          future: _fetchProducts,
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.done) {
            //   return ValueListenableBuilder<bool>(
            //       valueListenable: _showOnlyFavorites,
            //       builder: (context, onlyFavorites, child) {
            //         return ProductsGrid(onlyFavorites);
            //       });
            // }
            // return const Center(
            //   child: CircularProgressIndicator(),
            // );
            if (snapshot.connectionState == ConnectionState.done) {
              // var products =
              //     context.read<ProductsManager>().getListProducts('Headphone');
              // print(_fetchProducts);
              // var products = context.select<ProductsManager, List<Product>>(
              //       (productsManager) => productsManager.items);
              var products = context
                  .read<ProductsManager>()
                  .getListProductsByType(category);
              // print(liss.length);
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Banner
                      // const SizedBox(height: ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(20),
                      //     child: Container(
                      //       height: 150,
                      //       width: MediaQuery.of(context).size.width,
                      //       color: primaryCorlor.withOpacity(.6),
                      //       child: Stack(
                      //         children: [
                      //           Positioned(
                      //             bottom: 0,
                      //             child: ClipRRect(
                      //               borderRadius: BorderRadius.circular(30),
                      //               child: Container(
                      //                 height: 200,
                      //                 width: MediaQuery.of(context).size.width -
                      //                     40,
                      //                 color: orange200,
                      //                 child: Stack(
                      //                   children: [
                      //                     Positioned(
                      //                       left: 28,
                      //                       height: 273,
                      //                       child: SvgPicture.asset(
                      //                         "assets/panow.svg",
                      //                         color: white,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           // Positioned(
                      //           // child: Image.asset(
                      //           //   onBoard.image,
                      //           //   height: 500,
                      //           // ),
                      //           // ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      //Categories
                      // const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text(
                              'Categories',
                              style: TextStyle(
                                color: black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Text(
                                  'See all',
                                  style: TextStyle(
                                    color: secondCorlor,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: secondCorlor),
                                  child: const Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 14,
                                      color: white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      //Các danh mục
                      // const SizedBox(height: 15),
                      SingleChildScrollView(
                        child: Row(
                          children: [
                            const SizedBox(width: 20),
                            // Container(
                            //     padding: const EdgeInsets.symmetric(
                            //         vertical: 10, horizontal: 15),
                            //     decoration: const BoxDecoration(color: white),
                            //     child: const Icon(Icons.tune_rounded)),
                            ...List.generate(
                              categories.length,
                              (index) => Padding(
                                padding: index == 0
                                    ? const EdgeInsets.symmetric(horizontal: 20)
                                    : const EdgeInsets.only(right: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      category = categories[index];
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: categories[index] == category
                                          ? primaryCorlor
                                          : white,
                                      boxShadow: [
                                        categories[index] == category
                                            ? const BoxShadow(
                                                offset: Offset(0, 5),
                                                color: primaryCorlor,
                                                spreadRadius: 0,
                                                blurRadius: 10)
                                            : const BoxShadow(color: white)
                                      ],
                                    ),
                                    child: Text(
                                      categories[index],
                                      style: TextStyle(
                                          color: categories[index] == category
                                              ? white
                                              : black,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      //Sản phẩm
                      // const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text(
                              'Products',
                              style: TextStyle(
                                color: black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Text(
                                  'See all',
                                  style: TextStyle(
                                    color: secondCorlor,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ProductsOverviewScreen(
                                                // pet: ProductsManager
                                                //     .getListPet(category)[index]),
                                                ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: secondCorlor),
                                    child: const Icon(
                                        Icons.keyboard_arrow_right_rounded,
                                        size: 14,
                                        color: white),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      // const SizedBox(height: 15),
                      // Container(
                      //   height: 1000,

                      // child: Row(

                      //   children: List.generate(
                      //     listProducts.length,
                      //     (index) => Padding(
                      //       padding: index == 0
                      //           ? const EdgeInsets.only(
                      //               left: 20,
                      //               right: 20,
                      //             )
                      //           : const EdgeInsets.only(
                      //               right: 20,
                      //             ),
                      //       child: GestureDetector(
                      //         onTap: () {
                      //           // Navigator.of(context).pushNamed(
                      //           //   ProductDetailScreen.routeName,
                      //           //   arguments: product.id,
                      //           // );

                      //             Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                 builder: (context) => ProductDetailScreen(
                      //                   context.read<ProductsManager>().findById(listProducts[index].id as String)!,
                      //                 ),
                      //               ),
                      //             );
                      //         },
                      //         child: productItem(
                      //             context, listProducts[index]),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // child: HomeProductGrid(),

                      // ------------------->
                      // child: ListView.builder(
                      //   // physics: NeverScrollableScrollPhysics(),
                      //   // shrinkWrap: true,
                      //   scrollDirection: Axis.vertical,
                      //   itemCount: products.length,
                      //   itemBuilder: (context, index) => HomeProductGridTile(products[index])
                      // ),
                      //----------------------->
                      // ),
                      // Expanded(
                      ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          // shrinkWrap: true,
                          // scrollDirection: Axis.vertical,
                          itemCount: products.length,
                          itemBuilder: (context, index) =>
                              HomeProductGridTile(products[index])),
                      // )
                    ],
                  ),
                ),
              );
              return Column(
                // child: Column(
                children: [
                  // Banner
                  const SizedBox(height: 20),
                  BannerScreen(),
                  // buildSlideCard(),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(20),
                  //     child: Container(
                  //       height: 150,
                  //       width: MediaQuery.of(context).size.width,
                  //       color: primaryCorlor.withOpacity(.6),
                  //       child: Stack(
                  //         children: [
                  //           Positioned(
                  //             bottom: 0,
                  //             child: ClipRRect(
                  //               borderRadius: BorderRadius.circular(30),
                  //               child: Container(
                  //                 height: 200,
                  //                 width: MediaQuery.of(context).size.width - 40,
                  //                 color: orange200,
                  //                 child: Stack(
                  //                   children: [
                  //                     Positioned(
                  //                       left: 28,
                  //                       height: 273,
                  //                       child: SvgPicture.asset(
                  //                         "assets/panow.svg",
                  //                         color: white,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           // Positioned(
                  //           // child: Image.asset(
                  //           //   onBoard.image,
                  //           //   height: 500,
                  //           // ),
                  //           // ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  //Categories
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Text(
                          'Categories',
                          style: TextStyle(
                            color: black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Text(
                              'See all',
                              style: TextStyle(
                                color: secondCorlor,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: secondCorlor),
                              child: const Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  size: 14,
                                  color: white),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  //Các danh mục
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        // Container(
                        //     padding: const EdgeInsets.symmetric(
                        //         vertical: 10, horizontal: 15),
                        //     decoration: const BoxDecoration(color: white),
                        //     child: const Icon(Icons.tune_rounded)),
                        ...List.generate(
                          categories.length,
                          (index) => Padding(
                            padding: index == 0
                                ? const EdgeInsets.symmetric(horizontal: 20)
                                : const EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  category = categories[index];
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: categories[index] == category
                                      ? primaryCorlor
                                      : white,
                                  boxShadow: [
                                    categories[index] == category
                                        ? const BoxShadow(
                                            offset: Offset(0, 5),
                                            color: primaryCorlor,
                                            spreadRadius: 0,
                                            blurRadius: 10)
                                        : const BoxShadow(color: white)
                                  ],
                                ),
                                child: Text(
                                  categories[index],
                                  style: TextStyle(
                                      color: categories[index] == category
                                          ? white
                                          : black,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  //Sản phẩm
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Text(
                          'Products',
                          style: TextStyle(
                            color: black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Text(
                              'See all',
                              style: TextStyle(
                                color: secondCorlor,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductsOverviewScreen(
                                            // pet: ProductsManager
                                            //     .getListPet(category)[index]),
                                            ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: secondCorlor),
                                child: const Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    size: 14,
                                    color: white),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),
                  // Container(
                  //   height: 1000,

                  // child: Row(

                  //   children: List.generate(
                  //     listProducts.length,
                  //     (index) => Padding(
                  //       padding: index == 0
                  //           ? const EdgeInsets.only(
                  //               left: 20,
                  //               right: 20,
                  //             )
                  //           : const EdgeInsets.only(
                  //               right: 20,
                  //             ),
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           // Navigator.of(context).pushNamed(
                  //           //   ProductDetailScreen.routeName,
                  //           //   arguments: product.id,
                  //           // );

                  //             Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                 builder: (context) => ProductDetailScreen(
                  //                   context.read<ProductsManager>().findById(listProducts[index].id as String)!,
                  //                 ),
                  //               ),
                  //             );
                  //         },
                  //         child: productItem(
                  //             context, listProducts[index]),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // child: HomeProductGrid(),

                  // ------------------->
                  // child: ListView.builder(
                  //   // physics: NeverScrollableScrollPhysics(),
                  //   // shrinkWrap: true,
                  //   scrollDirection: Axis.vertical,
                  //   itemCount: products.length,
                  //   itemBuilder: (context, index) => HomeProductGridTile(products[index])
                  // ),
                  //----------------------->
                  // ),
                  Expanded(
                    child: ListView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                        // shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: products.length,
                        itemBuilder: (context, index) =>
                            HomeProductGridTile(products[index])),
                  )
                ],
                // ),
              );
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
        // print(CartManager().productCount);
        return TopRightBadge(

          data: total,

          // data: 1,
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

  Widget productItem(BuildContext context, Product product) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: MediaQuery.of(context).size.height * .35,
        width: MediaQuery.of(context).size.width * .6,
        color: white,
        child: Stack(
          children: [
            // Positioned(
            //   bottom: -10,
            //   right: -10,
            //   width: 100,
            //   height: 100,
            //   child: Transform.rotate(
            //     angle: 12,
            //     child: SvgPicture.asset(
            //       'assets/Paw_Print.svg',
            //       // color: ,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),Positioned(
            //   top: 50,
            //   left: -25,
            //   width: 100,
            //   height: 100,
            //   child: Transform.rotate(
            //     angle: -11.5,
            //     child: SvgPicture.asset(
            //       'assets/Paw_Print.svg',
            //       // color: color,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),

            Positioned(
              bottom: -10,
              right: 20,
              child: Image.asset(
                product.imageUrl,
                height: MediaQuery.of(context).size.height * .25,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(20),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Expanded(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               product.title,
            //               style: const TextStyle(
            //                   fontSize: 24,
            //                   color: black,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //             Row(
            //               children: [
            //                 const Icon(
            //                   Icons.location_on_outlined,
            //                   color: blue,
            //                   size: 14,
            //                 ),
            //                 Text(
            //                   'Distance 0 km)',
            //                   style: const TextStyle(
            //                       fontSize: 12, color: primaryCorlor),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //       Container(
            //         width: 40,
            //         height: 40,
            //         padding: const EdgeInsets.all(0),
            //         decoration: const BoxDecoration(
            //             shape: BoxShape.circle, color: white),
            //         child: ValueListenableBuilder<bool>(
            //           valueListenable: product.isFavoritrListenable,
            //           builder: (ctx, isFavorite, child) => IconButton(
            //             padding: const EdgeInsets.all(0),
            //             icon: Icon(
            //               size: 24,
            //               product.isFavorite
            //                   ? Icons.favorite_rounded
            //                   : Icons.favorite_outline_rounded,
            //               color:
            //                   product.isFavorite ? red : black.withOpacity(.6),
            //             ),
            //             onPressed: () {
            //               ctx
            //                   .read<ProductsManager>()
            //                   .toggleFavoriteStatus(product);
            //             },
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget buildSlideCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          color: primaryCorlor.withOpacity(.6),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width - 40,
                    color: orange200,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 28,
                          height: 273,
                          child: SvgPicture.asset(
                            "assets/panow.svg",
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Positioned(
              // child: Image.asset(
              //   onBoard.image,
              //   height: 500,
              // ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
