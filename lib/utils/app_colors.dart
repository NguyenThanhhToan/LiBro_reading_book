import 'package:flutter/material.dart';

class AppColors {
  static const Gradient backgroundColor = LinearGradient(
    colors: [
      Color.fromRGBO(196, 171, 212, 1),
      Color.fromARGB(255, 225, 172, 215),
      Color.fromARGB(255, 193, 214, 181),
    ],
    // colors: [
    //   Color(0xFFAF9CD0),
    //   Color(0xFFF2BCFF),
    //   Color(0xFF9AD0AE),
    // ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.5, 0.8]
  );

  static const Color secondaryColor = Color(0xFFD9D9D9);
  static const Color textColor = Color(0xFF333333);
}