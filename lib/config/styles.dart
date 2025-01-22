import 'package:flutter/material.dart';

const TextStyle appbarTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500
);

abstract class myTextStyles {

  static const TextStyle cardTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    height: 2.5,
    color: Colors.blue

  );

  static const TextStyle cardColumnHeading = TextStyle(
    fontSize: 24,
  );

  static const TextStyle cardColumnValue = TextStyle(
    fontSize: 24,
  );

  static const TextStyle cardButton = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.blue
  );
}