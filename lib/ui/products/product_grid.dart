import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_grid_tile.dart';

import 'products_manager.dart';

import '../../models/product.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;
  const ProductsGrid(this.showFavorites, {super.key});
  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
    final product = context.select<ProductsManager, List<Product>>(
        (productsManager) => showFavorites
            ? productsManager.favoriteItems
            : productsManager.items);
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: product.length,
        itemBuilder: (context, i) => ProductGridTile(product[i]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ));
  }
}
