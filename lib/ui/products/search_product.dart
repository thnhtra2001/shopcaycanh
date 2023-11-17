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
  static List<Product> product = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
  ];
  List<Product>? display_product = List.from(product);
  // late Future<void> _fetchProducts;

  // @override
  // void initState() {
  //   super.initState();
  //   // _fetchProducts = context.read<ProductsManager>().fetchProducts();
  //   // _items = context.read<ProductsManager>().items;
  // }
  void updateList(String value) {
    setState(() {
      display_product = product
          .where((element) =>
              element.title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAtra");
      print(display_product);
      // result = display_list
      //     .where((element) =>
      //         element.title!.toLowerCase().contains(element.title))
      //     .toList();
      //         print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAtra");
      // print(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final productsManager = context.read<ProductsManager>();

    // final product = context.select<ProductsManager, List<Product>>(
    //     (productsManager) => productsManager.items);
    // List<Product> display_list = List.from(product);
    // List<Product> result = [];

    // print(display_list[2].title);

    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body:
            // FutureBuilder(
            // future: _fetchProducts,
            // builder: (context, snapshot) {
            //   if (snapshot.connectionState == ConnectionState.done) {
            //     return
            Column(
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
              child: display_product!.length == 0
                  ? const Center(
                      child: Text(
                      'Tìm không thấy sản phẩm',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ))
                  : ListView.builder(
                      itemCount: display_product!.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(
                          display_product![index].title,
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          '${display_product![index].price!}',
                          style: TextStyle(color: Colors.black),
                        ),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(display_product![index].imageUrl),
                        ),
                      ),
                    ),
            ),
          ],
        ));
  }
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         },
  //       ));
  // }
}
