import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/products/products_manager.dart';

import '../../models/product.dart';
import 'product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic>? display_product = [];
  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     final productsManager = context.read<ProductsManager>();
  //     late List<Product> product = productsManager.items;
  //     print("AAAAAAAAAAAAAAAAAAAA");
  //     print(product.length);
  //     // lay tu day de hien thi xuong listview
  //     display_product = product;
  //   });
  // }
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
    // final productsManager = context.read<ProductsManager>();
    final product = context.select<ProductsManager, List<Product>>(
        (productsManager) => productsManager.display_product);
    late List<dynamic> map = product.map((e) => e.toJson()).toList();
    print("tra dep chai");
    print(map.length);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tìm kiếm'),
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
              child: product.length == 0
                  ? const Center(
                      child: Text(
                      '',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ))
                  : GroupedListView<dynamic, dynamic>(
                      elements: product.map((e) => e.toJson()).toList(),
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
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
                            print("AAAAAAAAAAAAAAAAAAAAaaa");
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailScreen(element)));
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
                    ))
        ]));
  }
}
