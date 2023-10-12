import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/add_product/edit_product_screen.dart';
import 'package:shopcaycanh/ui/shared/app_drawer.dart';

import 'user_product_list_title.dart';

import '../products/products_manager.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/admin-product';
  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
    return Scaffold(
      appBar: AppBar(
        title: const Text('San pham cua ban'),
        actions: [
          buildAddButton(context),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async => print('refresh product'),
        child: buildUserProductListView(productsManager),
      ),
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            EditProductScreen.routeName,
          );
        },
        icon: const Icon(Icons.add));
  }

  Widget buildUserProductListView(ProductsManager productsManager) {
    return Consumer<ProductsManager>(
      builder: (context, productsManager, child) {
        return ListView.builder(
          itemCount: productsManager.itemCount,
          itemBuilder: (context, index) => Column(
            children: [
              UserProductListTile(
                productsManager.items[index],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}
