import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/admin/personal_screen.dart';
import 'package:shopcaycanh/ui/admin/search_admin.dart';
import 'package:shopcaycanh/ui/cart/cart_manager.dart';
import 'package:shopcaycanh/ui/cart/cart_screen.dart';
import 'package:shopcaycanh/ui/chat/chat.dart';
import 'package:shopcaycanh/ui/orders/order_manager.dart';
import 'package:shopcaycanh/ui/orders/order_screen.dart';
import 'package:shopcaycanh/ui/orders_admin/order_manager.dart';
import 'package:shopcaycanh/ui/orders_admin/order_screen.dart';
import 'package:shopcaycanh/ui/payment_cart1/payment_cart_screen.dart';
import 'package:shopcaycanh/ui/pie_chart/pie_chart_manager.dart';
import 'package:shopcaycanh/ui/product_manager_admin/admin_product_manager.dart';
import 'package:shopcaycanh/ui/products/product_detail_screen.dart';
import 'package:shopcaycanh/ui/products/product_overview_screen.dart';
import 'package:shopcaycanh/ui/products/products_manager.dart';
import 'package:shopcaycanh/ui/products/search_product.dart';
import 'package:shopcaycanh/ui/screens.dart';
import 'ui/cart/cart_manager1.dart';
import 'ui/chatbot_rasa_ai/chatbot_rasa_ai.dart';
import 'ui/admin/user_product_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'ui/orders1_admin/order_manager.dart';
import 'ui/orders1_admin/order_screen.dart';
import 'ui/orders2_admin/order_manager.dart';
import 'ui/orders2_admin/order_screen.dart';
import 'ui/orders3_admin/order_manager.dart';
import 'ui/orders3_admin/order_screen.dart';
import 'ui/pie_chart/pie_chart.dart';
import 'ui/product_manager_admin/admin_product_screens.dart';
import 'ui/screens.dart';
import 'ui/personal/personal_screen.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProductsManager()),
          ChangeNotifierProvider(create: (context) => CartManager()),
          ChangeNotifierProvider(create: (context) => OrdersManager()),
          ChangeNotifierProvider(create: (context) => AuthManager()),
          ChangeNotifierProvider(create: (context) => CartManager1()),
          ChangeNotifierProvider(create: (context) => OrdersManagerAdmin()),
          ChangeNotifierProvider(create: (context) => OrdersManagerAdmin1()),
          ChangeNotifierProvider(create: (context) => OrdersManagerAdmin2()),
          ChangeNotifierProvider(create: (context) => OrdersManagerAdmin3()),
          ChangeNotifierProvider(create: (context) => PieChartManager(),),
          ChangeNotifierProvider(create: (context) => AdminProductsManager(),)



        ],
        child: Consumer<AuthManager>(builder: (context, authManager, child) {
          return MaterialApp(
            title: 'CayCanh',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Lato',
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.purple,
              ).copyWith(secondary: Colors.deepOrange),
            ),
            home: authManager.isAuth
                ? (context.read<AuthManager>().authToken?.role == "admin"
                    ? UserProductsScreen()
                    : const ProductOverviewScreen())
                : FutureBuilder(
                    future: authManager.tryAutoLogin(),
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : const AuthScreen();
                    },
                  ),
            routes: {
              CartScreen.routeName: (context) => const CartScreen(),
              ChatScreen.routeName:(context) => ChatScreen(),
              OrdersScreen.routeName: (context) => const OrdersScreen(),
              UserProductsScreen.routeName: (context) =>
                  const UserProductsScreen(),
              PersonalScreen.routeName: (context) => const PersonalScreen(),
              PersonalScreenAdmin.routeName: (context) => const PersonalScreenAdmin(),

              PaymentCartScreen1.routeName: (context) =>
                  const PaymentCartScreen1(),
              SearchScreen.routeName:(context) => const SearchScreen(),
              ChatbotScreen1.routeName:(context) => const ChatbotScreen1(),
              SearchAdminScreen.routeName: (context) => const SearchAdminScreen(),
              OrdersScreenAdmin.routeName: (context) => const OrdersScreenAdmin(),
              OrdersScreenAdmin1.routeName: (context) => const OrdersScreenAdmin1(),
              OrdersScreenAdmin2.routeName: (context) => const OrdersScreenAdmin2(),
              OrdersScreenAdmin3.routeName: (context) => const OrdersScreenAdmin3(),
              PieChartScreen.routeName:(context) => PieChartScreen(),
              AdminProductManagerScreens.routeName:(context) => const AdminProductManagerScreens(),

            },
            onGenerateRoute: (settings) {
              if (settings.name == ProductDetailScreen.routeName) {
                final productId = settings.arguments as String;
                return MaterialPageRoute(builder: (context) {
                  return ProductDetailScreen(
                    ProductsManager().findById(productId),
                  );
                });
              }
              if (settings.name == EditProductScreen.routeName) {
                final productId = settings.arguments as String?;
                return MaterialPageRoute(builder: (context) {
                  return EditProductScreen(
                    productId != null
                        ? context.read<ProductsManager>().findById(productId)
                        : null,
                  );
                });
              }
              return null;
            },
          );
        }));
  }
}
