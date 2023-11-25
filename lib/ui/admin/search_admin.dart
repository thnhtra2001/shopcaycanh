import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/products/products_manager.dart';

import '../../models/product.dart';
import 'edit_product_screen.dart';

class SearchAdminScreen extends StatefulWidget {
  static const routeName = '/search1';

  const SearchAdminScreen({super.key});
  @override
  State<SearchAdminScreen> createState() => _SearchAdminScreenState();
}

class _SearchAdminScreenState extends State<SearchAdminScreen> {
  List<Product>? display_product = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      final productsManager = context.read<ProductsManager>();
      late List<Product> product = productsManager.items;
      print("AAAAAAAAAAAAAAAAAAAA");
      print(product.length);
      // lay tu day de hien thi xuong listview
      display_product = product;
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsManager = context.read<ProductsManager>();
    final product = context.select<ProductsManager, List<Product>>(
        (productsManager) => productsManager.display_product);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tìm kiếm - Admin'),
        ),
        body: Column(children: [
          TextField(
            onChanged: (value) => setState(() {
              context.read<ProductsManager>().updateList(value);
            }),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Tìm kiếm",
                prefixIcon: Icon(Icons.search)),
          ),
          SizedBox(height: 20),
          Expanded(
              child: product!.length == 0
                  ? const Center(
                      child: Text(
                      '',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ))
                  : ListView.builder(
                      itemCount: productsManager.display_product_Count,
                      itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) =>
                          //         ProductDetailScreen(product[index])));
                        },
                        title: Text(
                          product[index].title,
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          '${product[index].price}',
                          style: TextStyle(color: Colors.black),
                        ),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(product[index].imageUrl),
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              buildEditButton(context, product[index]),
                              buildDeleteButton(context, product[index]),
                            ],
                          ),
                        ),
                      ),
                    ))
        ]));
  }

  Widget buildEditButton(BuildContext context, product) {
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

    Widget buildDeleteButton(BuildContext context, product) {
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
