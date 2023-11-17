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
  List<Product>? display_product = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      // final productsManager = context.read<ProductsManager>();
      // late List<Product> product = productsManager.display_product;
      // print(product.length);
      //// lay tu day de hien thi xuong listview
      // display_product = product;
    });
  }
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tìm kiếm'),
        ),
        body: Column(children: [
          TextField(
            onChanged: (value) =>
            setState(() {
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
                      'Tìm không thấy sản phẩm',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ))
                  : ListView.builder(
                      itemCount: productsManager.display_product_Count,
                      itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          print("on tap now");
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
                      ),
                    ))
        ]));
  }
}
