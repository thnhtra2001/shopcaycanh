import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/admin/edit_product_screen.dart';
import 'package:shopcaycanh/ui/shared/admin_app_drawer.dart';

import 'user_product_list_title.dart';

import '../products/products_manager.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/admin-product';
  const UserProductsScreen({super.key});

  Future<void> _refreshProduct(BuildContext context) async {
    await context.read<ProductsManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Admin'),
          actions: [
            buildAddButton(context),
          ],
        ),
        drawer: const AdminAppDrawer(),
        body: FutureBuilder(
          future: _refreshProduct(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return RefreshIndicator(
              onRefresh: () => _refreshProduct(context),
              child: buildUserProductListView(productsManager),
            );
          },
        ));
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
