import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  /// MARK: - Initials;
  final String? title;
  final String? value;

  const CustomRichText({Key? key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title ?? '',
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
            text: value ?? '',
            style:const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomRowText extends StatelessWidget {
  /// MARK: - Initials;
  final String? title;
  final String? value;
  final Color? textColor;
  final Color? textColorNumber;
  const CustomRowText({
    Key? key,
    this.title,
    this.value,
    this.textColor = Colors.black,
    this.textColorNumber = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? '',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          Text(
            value ?? '',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}