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
  // final  product = ProductsManager().items;

  // static List<Product> product1 = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
  // ];
  // List<Product>? display_product = [];
  // late Future<void> _fetchProducts;

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     // final productsManager = context.read<ProductsManager>();
  //     // late List<Product> product = productsManager.items;
  //     // print(product.length);
  //     //// lay tu day de hien thi xuong listview
  //     display_product = product;
  //     print(display_product!.length);
  //   });

  // _fetchProducts = context.read<ProductsManager>().fetchProducts();
  // }
  // truyen vao chuoi dua vao do de loc ra title
  // void updateList(String value) {
  //   setState(() {
  //     display_product = product
  //         .where((element) =>
  //             element.title.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //     print("AAAAAAAAAAAAAAAAAAA");
  //     print(value);
  //     print(display_product);

  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final productsManager = context.read<ProductsManager>();
    final product = context.select<ProductsManager, List<Product>>(
        (productsManager) => productsManager.display_product);
    print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB");
    print(product.last.title);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tìm sản phẩm'),
        ),
        body:
            Column(
          children: [
            TextField(
              onChanged: (value) =>
                  context.read<ProductsManager>().updateList(value),
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
                        'Tìm không thấy sản phẩm',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                    : Consumer<ProductsManager>(
                        builder: (context, productsManager, child) {
                          return ListView.builder(
                            itemCount: productsManager.display_product_Count,
                            itemBuilder: (context, index) => ListTile(
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
                            ),
                          );
                        },
                      )),
          ],
        ));
  }
}
