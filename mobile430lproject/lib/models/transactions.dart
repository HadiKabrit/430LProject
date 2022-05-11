import 'dart:ffi';

class Transaction {
  final double usdAmount;
  final double lbpAmount;
  final bool usdtolbp;

  const Transaction({
    required this.usdAmount,
    required this.lbpAmount,
    required this.usdtolbp,
  });
}
