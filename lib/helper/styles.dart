import 'package:flutter/material.dart';

const TextStyle appbarTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500
);

abstract class MyTextStyles {

  static const TextStyle cardTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    //height: 2.5,
    color: Colors.blue

  );

  static const TextStyle cardColumnHeading = TextStyle(
    fontSize: 24,
  );

  static const TextStyle cardColumnValue = TextStyle(
    fontSize: 24,
  );

  static const TextStyle cardButton = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black
  );

  static const TextStyle radioArabicBaab = TextStyle(
      fontSize: 24,
  );
}