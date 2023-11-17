// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shopcaycanh/ui/admin/edit_product_screen.dart';
// import 'package:shopcaycanh/ui/products/products_manager.dart';

// import '../../models/product.dart';
// import '../products/product_detail_screen.dart';

// class SearchListTile extends StatelessWidget {
//   static const routeName = '/search_list_tile';
//   final Product product;

//   const SearchListTile(
//     this.product, {
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => ProductDetailScreen(product)));
//       },
//       title: Text(product.title),
//       subtitle: Text(
//         '${product.price}',
//         style: TextStyle(color: Colors.black),
//       ),
//       leading: CircleAvatar(
//         backgroundImage: NetworkImage(product.imageUrl),
//       ),
//     );
//   }
// }
