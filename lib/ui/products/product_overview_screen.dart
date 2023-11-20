import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/cart/cart_manager.dart';
import 'package:shopcaycanh/ui/cart/cart_screen.dart';
import 'package:shopcaycanh/ui/products/products_manager.dart';
import 'package:shopcaycanh/ui/products/search_product.dart';
import 'package:shopcaycanh/ui/products/top_right_badge.dart';
import 'package:shopcaycanh/ui/shared/app_drawer.dart';

import 'product_grid.dart';

enum FilterOptions {favorites, all}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
    print(_fetchProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shop cây cảnh'),
          actions: <Widget>[
            buildProductFilterMenu(),
            // buildShoppingCartIcon(),
            searchProduct(),
          ],
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
          future: _fetchProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // return ProductsGrid(_showOnlyFavorites);
              return ValueListenableBuilder<bool>(
                  valueListenable: _showOnlyFavorites,
                  builder: (context, onlyFavorites, child) {
                    return ProductsGrid(onlyFavorites);
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Widget searchProduct() {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(SearchScreen.routeName);
        },
        icon: const Icon(Icons.search));
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(
      builder: (context, cartManager, child) {
        return TopRightBadge(
          data: cartManager.productCount,
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: const Icon(Icons.shopping_cart)),
        );
      },
    );
  }

  Widget buildProductFilterMenu() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        setState(() {
          if (selectedValue == FilterOptions.favorites) {
            _showOnlyFavorites.value = true;
          } else {
            _showOnlyFavorites.value = false;
          }
        });
      },
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Only Favorites'),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text('Show All'),
        ),
      ],
    );
  }
}

// class MySearch extends SearchDelegate {
//       List<String> searchResult = [
//       'Brazil',
//       'VietNam',
//       'China',
//       'Korea',
//       'Japanse'
//     ];
//   @override
//   Widget buildLeading(BuildContext context) => IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () => close(context, null));
//   @override
//   List<Widget>? buildActions(BuildContext context) => [
//         IconButton.filled(
//             onPressed: () {
//               if (query.isEmpty) {
//                 close(context, null);
//               } else {
//                 query = '';
//               }
//             },
//             icon: const Icon(Icons.clear))
//       ];
//   @override
//   Widget buildResults(BuildContext context) => Center(
//         child: Text(
//           query,
//           style: TextStyle(color: Colors.yellow, fontSize: 50),
//         ),
//       );
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> suggestions = ['Vietnam'];
//     return ListView.builder(
//         itemCount: suggestions.length,
//         itemBuilder: (context, index) {
//           final suggestion = suggestions[index];
//           return ListTile(
//             title: Text(suggestion),
//             onTap: () {
//               query = suggestion;
//               showResults(context);
//             },
//           );
//         });
//   }
// }
