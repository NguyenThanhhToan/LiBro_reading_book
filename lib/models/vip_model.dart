import 'dart:ui';

class VipModel{
  final int time;
  final int amount;
  final Color backgroundColor;

  VipModel({
    required this.time,
    required this.amount,
    required this.backgroundColor,
  });

  String get displayTime => "$time THÁNG";
  String get displayAmount => "${amount.toString().replaceAllMapped(RegExp(r"(\d)(?=(\d{3})+(?!\d))"), (match) => "${match[1]}.")}đ";

}