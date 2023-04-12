import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:panow/ui/home/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:panow/ui/control_screen.dart';

Future<void> main() async {
  // (1) Load the .env file
  await dotenv.load();
  // Chuẩn bị môi trường hoạt động cho các widget trong ứng dụng.
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // (2) Create and provide AuthManager
        ChangeNotifierProvider(create: (context) => AuthManager()),
        ChangeNotifierProxyProvider<AuthManager, ProductsManager>(
            create: (ctx) => ProductsManager(),
            update: (ctx, authManager, productsManager) {
              // Khi authManager có báo hiệu thay đổi thì đọc lại authToken cho productManager
              productsManager!.authToken = authManager.authToken;
              return productsManager;
            }),
        ChangeNotifierProvider(create: (ctx) => CartManager()),
        ChangeNotifierProvider(create: (ctx) => OrdersManager()),
        ChangeNotifierProvider(create: (ctx) => OrdersManager()),
      ],
      child: MaterialApp(
        title: 'PanOw Tech',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          fontFamily: 'SFCompactRounded',
          primaryColor: primaryCorlor,
          scaffoldBackgroundColor: grey,
        ),
        home: AnimatedSplashScreen(
          duration: 1000,
          splashIconSize: 500,
          splash: Column(
            children: [
              SvgPicture.asset(
                "assets/panow.svg",
                color: primaryCorlor,
                height: 500,
              ),
            ],
          ),
          nextScreen: const OnBoardScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: white,
        ),
        routes: {
          CartScreen.routeName: (ctx) => const CartScreen(),
          SearchScreen.routeName: (ctx) => const SearchScreen(),
          OrderScreen.routeName: (ctx) => const OrderScreen(),
          UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
          HomePageScreen.routeName: (ctx) => const HomePageScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == ProductDetailScreen.routeName) {
            final productId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (ctx) {
                return ProductDetailScreen(
                  ctx.read<ProductsManager>().findById(productId)!,
                );
              },
            );
          }

          if (settings.name == EditProductScreen.routeName) {
            final productId = settings.arguments as String?;
            return MaterialPageRoute(
              builder: (ctx) {
                return EditProductScreen(
                  productId != null
                      ? ctx.read<ProductsManager>().findById(productId)
                      : null,
                );
              },
            );
          }

          return null;
        },
      ),

      // (3) Consume the AuthManager instance
      //   child: Consumer<AuthManager>(
      //     builder: (ctx, authManager, child) {
      //       return MaterialApp(
      //         title: 'MyShop',
      //         debugShowCheckedModeBanner: false,
      //         theme: ThemeData(
      //           fontFamily: 'Roboto',
      //           colorScheme: ColorScheme.fromSwatch(
      //             primarySwatch: Colors.blue,
      //           ).copyWith(
      //             secondary: Colors.deepOrange,
      //           ),
      //         ),
      //         home: authManager.isAuth
      //             ? const ProductsOverviewScreen()
      //             : FutureBuilder(
      //                 future: authManager.tryAutoLogin(),
      //                 builder: (ctx, snapshot) {
      //                   return snapshot.connectionState == ConnectionState.waiting
      //                       ? const SplashScreen()
      //                       : const AuthScreen();
      //                 },
      //               ),
      //         routes: {
      //           CartScreen.routeName: (ctx) => const CartScreen(),
      //           OrdersScreen.routeName: (ctx) => const OrdersScreen(),
      //           UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
      //         },
      //         onGenerateRoute: (settings) {
      //           if (settings.name == ProductDetailScreen.routeName) {
      //             final productId = settings.arguments as String;
      //             return MaterialPageRoute(
      //               builder: (ctx) {
      //                 return ProductDetailScreen(
      //                   ctx.read<ProductsManager>().findById(productId)!,
      //                 );
      //               },
      //             );
      //           }

      //           if (settings.name == EditProductScreen.routeName) {
      //             final productId = settings.arguments as String?;
      //             return MaterialPageRoute(
      //               builder: (ctx) {
      //                 return EditProductScreen(
      //                   productId != null
      //                       ? ctx.read<ProductsManager>().findById(productId)
      //                       : null,
      //                 );
      //               },
      //             );
      //           }

      //           return null;
      //         },
      //       );
      //     },
      // ),
    );
  }
}
