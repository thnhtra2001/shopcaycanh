import 'package:flutter/material.dart';
import 'package:shopcaycanh/ui/products/product_detail_screen.dart';
import 'package:shopcaycanh/ui/products/products_manager.dart';

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
        home: SafeArea(
          child: ProductDetailScreen(
            ProductsManager().items[0],
          ),
        ));
  }
}
