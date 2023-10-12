import 'dart:math';

import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0, top: 44),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 94.0,
      ),
      // transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(20),
      //   color: Colors.deepOrange.shade900,
      //   boxShadow: const [
      //     BoxShadow(
      //       blurRadius: 8,
      //       color: Colors.black26,
      //       offset: Offset(0, 2),
      //     )
      //   ],
      // ),
      // child: Text(
      //   'My Book,
      //   style: TextStyle(
      //     color: Theme.of(context).textTheme.titleLarge?.color,
      //     fontSize: 50,
      //     fontFamily: 'Anton',
      //     fontWeight: FontWeight.normal,
      //   ),
      // ),

      child: Image.asset('assets/Images/logo.png'),
    );
  }
}
