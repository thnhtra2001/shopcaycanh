import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/cart/cart_manager.dart';
import 'package:shopcaycanh/ui/cart/cart_screen.dart';
import 'package:shopcaycanh/ui/orders/order_manager.dart';
import 'package:shopcaycanh/ui/orders/order_screen.dart';
import 'package:shopcaycanh/ui/products/product_detail_screen.dart';
import 'package:shopcaycanh/ui/products/product_overview_screen.dart';
import 'package:shopcaycanh/ui/products/products_manager.dart';
import 'ui/products/product_overview_screen.dart';

import 'ui/admin/user_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ProductsManager()
          ),
          ChangeNotifierProvider(create: (context)=>CartManager()),
          ChangeNotifierProvider(create: (context) => OrdersManager()),
          
        ],
        child: MaterialApp(
          title: 'My Shop',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.purple,
            ).copyWith(secondary: Colors.deepOrange),
          ),
          home: const ProductOverviewScreen(),
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
            return null;
          },
        ));
  }
}
