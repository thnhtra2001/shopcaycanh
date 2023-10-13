import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/cart/cart_manager.dart';
import 'package:shopcaycanh/ui/cart/cart_screen.dart';
import 'package:shopcaycanh/ui/orders/order_manager.dart';
import 'package:shopcaycanh/ui/orders/order_screen.dart';
import 'package:shopcaycanh/ui/products/product_detail_screen.dart';
import 'package:shopcaycanh/ui/products/product_overview_screen.dart';
import 'package:shopcaycanh/ui/products/products_manager.dart';
import 'package:shopcaycanh/ui/screens.dart';
import 'ui/products/product_overview_screen.dart';

import 'ui/admin/user_product_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'ui/screens.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProductsManager()),
          // ChangeNotifierProxyProvider<AuthManager, ProductsManager>(
          //     create: (context) => ProductsManager(),
          //     update: (context, authManager, productsManager) {
          //       productsManager!.authToken = authManager.authToken;
          //       return productsManager;
          //     }),
          ChangeNotifierProvider(create: (context) => CartManager()),
          ChangeNotifierProvider(create: (context) => OrdersManager()),
          ChangeNotifierProvider(create: (context) => AuthManager()),
        ],
        child: Consumer<AuthManager>(builder: (context, authManager, child) {
          return MaterialApp(
            title: 'Book Shop',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Lato',
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.purple,
              ).copyWith(secondary: Colors.deepOrange),
            ),
            home:
                // const ProductOverviewScreen(),
                authManager.isAuth
                    ?
                    // const ProductOverviewScreen()
                    (context.read<AuthManager>().authToken?.role == "admin"
                        ? UserProductsScreen()
                        : const ProductOverviewScreen())
                    : FutureBuilder(
                        future: authManager.tryAutoLogin(),
                        builder: (context, snapshot) {
                          return snapshot.connectionState ==
                                  ConnectionState.waiting
                              ? const SplashScreen()
                              : const AuthScreen();
                        },
                      ),
            routes: {
              CartScreen.routeName: (context) => const CartScreen(),
              OrdersScreen.routeName: (context) => const OrdersScreen(),
              UserProductsScreen.routeName: (context) =>
                  const UserProductsScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == ProductDetailScreen.routeName) {
                final productId = settings.arguments as String;
                return MaterialPageRoute(builder: (context) {
                  return ProductDetailScreen(
                    ProductsManager().findById(productId),
                  );
                });
              }
              if (settings.name == EditProductScreen.routeName) {
                final productId = settings.arguments as String?;
                return MaterialPageRoute(builder: (context) {
                  return EditProductScreen(
                    productId != null
                        ? context.read<ProductsManager>().findById(productId)
                        : null,
                  );
                });
              }
              return null;
            },
          );
        }));
  }
}
