import 'dart:async';
import 'package:flutter/material.dart';

Timer startAutoScrollTimer({
  required PageController controller,
  required int itemCount,
  Duration duration = const Duration(seconds: 3),
}) {
  int currentPage = 0;
  return Timer.periodic(duration, (timer) {
    if (controller.hasClients) {
      currentPage = (currentPage + 1) % itemCount;
      controller.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  });
}
