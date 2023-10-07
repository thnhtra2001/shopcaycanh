import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'My Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ).copyWith(secondary: Colors.deepOrange),
      ),
      home: const SafeArea(
        child: UserProductsScreen(),
      ),
    );
  }
}
