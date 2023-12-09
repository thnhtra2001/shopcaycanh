import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/admin/edit_product_screen.dart';
import 'package:shopcaycanh/ui/admin/search_admin.dart';
import 'package:shopcaycanh/ui/shared/admin_app_drawer.dart';

import '../../services/user_service.dart';
import 'admin_user_manager.dart';
import 'user_product_list_title.dart';

import '../products/products_manager.dart';

class AdminUserScreen extends StatefulWidget {
  static const routeName = '/admin-user';
  AdminUserScreen({super.key});
  @override
  State<AdminUserScreen> createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {
  late Future<void> _fetchAllUser;

  @override
  void initState() {
    super.initState();
    _fetchAllUser = context.read<AdminUserManager>().fetchAllUser();
    print("-----------");
    print(_fetchAllUser.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AdminUserManager>();
    final allUser = user.allUser;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quản lý người dùng'),
        ),
        drawer: const AdminAppDrawer(),
        body: FutureBuilder(
          future: _fetchAllUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SizedBox(
                height: 500,
                child: Container(
                    child: ListView.builder(
                  itemCount: allUser.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              'Tên người dùng: ${allUser[index].name}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Vai trò: ${allUser[index].role}',
                              style: TextStyle(color: Colors.red),
                            ),
                            // trailing: SizedBox(
                            //   width: 100,
                            //   child: Row(
                            //     children: [
                            //       IconButton(
                            //         onPressed: () {
                            //           context
                            //               .read<AdminUserManager>()
                            //               .deleteUser(allUser[index].uid);
                            //           ScaffoldMessenger.of(context)
                            //             ..hideCurrentMaterialBanner()
                            //             ..showSnackBar(const SnackBar(
                            //                 content: Text(
                            //               'Người dùng đã được xóa!',
                            //               textAlign: TextAlign.center,
                            //             )));
                            //         },
                            //         icon: const Icon(Icons.delete),
                            //         color: Theme.of(context).colorScheme.error,
                            //       )
                            //     ],
                            //   ),
                            // ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              'Địa chỉ: ${allUser[index].address}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          const Divider()
                        ],
                      ),
                    );
                  },
                )));
            // return SingleChildScrollView(child: Consumer<AdminUserManager>(
            //   builder: (context, value, child) {
            //     return ListView.builder(
            //       itemCount: value.allUserCount,
            //       itemBuilder: (context, index) => Column(
            //         children: [
            //           AllUserListTile(
            //             value.allUser[index],
            //           ),
            //           const Divider(),
            //         ],
            //       ),
            //     );
            //   },
            // ));
            //     child: Column(
            //   children: [
            //     const SizedBox(
            //       height: 20,
            //     ),
            //     const SizedBox(
            //       height: 20,
            //     ),
            //     SizedBox(
            //         height: 700,
            //         child: buildUserProductListView(productsManager)),
            //   ],
            // ));
          },
        ));
  }
  //   Widget buildDeleteButton(BuildContext context) {
  //   return IconButton(
  //     onPressed: () {
  //       context.read<ProductsManager>().deleteProduct(allUserid!);
  //       ScaffoldMessenger.of(context)
  //         ..hideCurrentMaterialBanner()
  //         ..showSnackBar(const SnackBar(
  //             content: Text(
  //           'Sản phẩm đã được xóa!',
  //           textAlign: TextAlign.center,
  //         )));
  //     },
  //     icon: const Icon(Icons.delete),
  //     color: Theme.of(context).colorScheme.error,
  //   );
  // }
}
