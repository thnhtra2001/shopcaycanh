import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/products/products_manager.dart';

import '../../models/product.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<void> _fetchProducts;
  // late List<Product> _items = ProductsManager().items;

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
    // _items = context.read<ProductsManager>().items;
  }

  @override
  Widget build(BuildContext context) {
    final productsManager = context.read<ProductsManager>();

    final product = context.select<ProductsManager, List<Product>>(
        (productsManager) => productsManager.items);
    // List<Product> display_list = List.from(product);
    // List<Product> result = [];
    List<Product>? display_list = List.from(product);

    // print(display_list[2].title);

    List<Product>? result = [];

    void updateList(String value) {
      setState(() {

        result = display_list
            .where((element) =>
                element.title!.toLowerCase().contains(element.title))
            .toList();
                print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAtra");
        print(result);
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: FutureBuilder(
          future: _fetchProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  TextField(
                    onChanged: (value) => updateList(value),
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
                    child: ListView.builder(
                      itemCount: product.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(
                          product[index].title!,
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
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
