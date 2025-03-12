import 'package:flutter/material.dart';

class AppColors {
  static const Gradient backgroundColor = LinearGradient(
    colors: [
      Color(0xFFAF9CD0),
      Color(0xFFF2BCFF),
      Color(0xFF9AD0AE),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.5, 1]
  );

  static const Color secondaryColor = Color(0xFFD9D9D9);
  static const Color textColor = Color(0xFF333333);
}