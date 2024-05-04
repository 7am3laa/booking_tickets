
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CardText extends StatelessWidget {
  Color textColor;
  double fontSize;
  String textContent;
  String? textWeight = 'No';
  CardText(
      {required this.textContent,
      required this.textColor,
      required this.fontSize,
      this.textWeight,
      super.key});

  @override
  Widget build(BuildContext context) {
    if (textWeight == 'No') {
      return Text(
        textContent,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
        ),
      );
    } else {
      return Text(
        textContent,
        style: TextStyle(
            fontSize: fontSize, color: textColor, fontWeight: FontWeight.bold),
      );
    }
  }
}
