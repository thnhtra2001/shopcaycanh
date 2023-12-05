import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

import '../cart/cart_manager.dart';
import 'product_detail_screen.dart';
import 'product_grid_tile.dart';

import 'products_manager.dart';

import '../../models/product.dart';

class ProductsGrid extends StatefulWidget {
  final bool showFavorites;
  const ProductsGrid(this.showFavorites, {super.key});

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  @override
  Widget build(BuildContext context) {
    final product = context.select<ProductsManager, List<Product>>(
        (productsManager) => productsManager.items);

    ///A
    ///
    late List<dynamic> map = product.map((e) => e.toJson()).toList();
    return GroupedListView<dynamic, dynamic>(
      elements: map,
      groupBy: (elements) => elements['type'],
      groupSeparatorBuilder: (dynamic groupByValue) => Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Flexible(
                child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    groupByValue,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
      itemBuilder: (context, dynamic element) {
        return ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetailScreen(element)));
          },
          title: Text(
            element['title'],
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            '${element['price']}',
            style: TextStyle(color: Colors.black),
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(element['imageUrl']),
          ),
          trailing: SizedBox(
              width: 100,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    buildAdd(element),
                    // buildDeleteButton(context, product[index]),
                  ],
                ),
              )),
        );
        //////////////////
        // return GestureDetector(
        //   onTap: () {
        //     print("AAAAAAAAAAAAAAAaa");
        //   },
        //   child: Card(
        //     elevation: 10,
        //     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //     child: Container(
        //       padding: EdgeInsets.all(10),
        //       child: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Expanded(
        //                 child: ClipRect(
        //               child: Image(
        //                 image: NetworkImage(element['imageUrl']),
        //                 fit: BoxFit.cover,
        //               ),
        //             )),
        //             Expanded(
        //               flex: 5,
        //               child: Container(
        //                 padding: EdgeInsets.only(bottom: 10),
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Padding(
        //                       padding: EdgeInsets.only(left: 10, right: 10),
        //                       child: Text(
        //                         element['title'],
        //                         style: const TextStyle(
        //                             fontSize: 16, fontWeight: FontWeight.bold),
        //                         maxLines: 2,
        //                       ),
        //                     ),
        //                     Padding(
        //                       padding: EdgeInsets.only(left: 10, right: 10),
        //                       child: Text(
        //                         element['price'].toString(),
        //                         style: const TextStyle(fontSize: 14),
        //                         maxLines: 2,
        //                       ),
        //                     )
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ]),
        //     ),
        //   ),
        // );
      },
      itemComparator: (item1, item2) =>
          item1['title'].compareTo(item2['title']),
      useStickyGroupSeparators: true,
      floatingHeader: true,
      order: GroupedListOrder.ASC,
    );
    /////B
    ///
    // return GridView.builder(
    //     padding: const EdgeInsets.all(10),
    //     itemCount: product.length,
    //     itemBuilder: (context, i) => ProductGridTile(product[i]),
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       childAspectRatio: 2 / 2,
    //       crossAxisSpacing: 10,
    //       mainAxisSpacing: 10,
    //     ));
  }

  Widget buildAdd(element) {
    return IconButton(
      onPressed: () async {
        final cart = context.read<CartManager>();
        cart.addItem(element);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: const Text('Đã thêm vào giỏ hàng!'),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Xóa',
              onPressed: () {
                cart.removeSingleItem(element);
              },
            ),
          ));
      },
      icon: const Icon(Icons.shopping_cart),
      color: Theme.of(context).colorScheme.error,
    );
  }
}
