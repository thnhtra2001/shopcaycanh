// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../../models/payment.dart';

// class PaymentItemCard extends StatefulWidget {
//   final Payment payment;
//   const PaymentItemCard(this.payment, {super.key});

//   @override
//   State<PaymentItemCard> createState() => _PaymentItemCardState();
// }

// class _PaymentItemCardState extends State<PaymentItemCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(10),
//       child: Column(
//         children: <Widget>[buildOrderDetails()],
//       ),
//     );
//   }

//   Widget buildOrderDetails() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
//       height: min(widget.payment.productSelectedCount * 20.0 + 10, 100),
//       child: ListView(
//         children: widget.payment.products
//             .map(
//               (products) => Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     products.title,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     '${products.quantity}x\$${products.price}',
//                     style: const TextStyle(
//                       fontSize: 18,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }
// }
