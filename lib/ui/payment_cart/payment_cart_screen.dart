// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shopcaycanh/models/payment_cart.dart';

// import 'payment_cart_item.dart';
// import 'payment_cart_manager.dart';
// import '../payment_cart/payment_cart_item.dart';

// class PaymentCartScreen extends StatelessWidget {
//   static const routeName = '/payment-cart';
//   const PaymentCartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final paymentsManager = PaymentsManager();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Trang thanh toán'),
//       ),
//       body: 
//       Consumer<PaymentsManager>(
//         builder: (ctx, paymentsManager, child) {
//           return ListView.builder(
//             itemCount: 1,
//             itemBuilder: (ctx, i) => PaymentItemCard(paymentsManager.payment[i]),
//           );
//         },
//       ),

//     );
    
//   }
// }