import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/admin/edit_product_screen.dart';
import 'package:shopcaycanh/ui/products/products_manager.dart';

import '../../models/product.dart';
import '../products/product_detail_screen.dart';

class UserProductListTile extends StatelessWidget {
  static const routeName = '/admin-products';
  final Product product;

  const UserProductListTile(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            buildEditButton(context),
            buildDeleteButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
          arguments: product.id,
        );
      },
      icon: const Icon(Icons.edit),
      color: Theme.of(context).colorScheme.error,
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<ProductsManager>().deleteProduct(product.id!);
        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showSnackBar(const SnackBar(
              content: Text(
            'Sản phẩm đã được xóa!',
            textAlign: TextAlign.center,
          )));
      },
      icon: const Icon(Icons.delete),
      color: Theme.of(context).colorScheme.error,
    );
  }
}
