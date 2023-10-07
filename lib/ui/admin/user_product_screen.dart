import 'package:flutter/material.dart';

import 'user_product_list_title.dart';

import '../products/products_manager.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
    return Scaffold(
      appBar: AppBar(
        title: const Text('San pham cua ban'),
        actions: [
          buildAddButton(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => print('refresh product'),
        child: buildUserProductListView(productsManager),
      ),
    );
  }

  Widget buildAddButton() {
    return IconButton(
        onPressed: () {
          print('go to add product screen');
        },
        icon: const Icon(Icons.add));
  }

  Widget buildUserProductListView(ProductsManager productsManager) {
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
  }
}
