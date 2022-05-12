import 'dart:ffi';

class Offer {
  final double usdAmount;
  final double rate;
  final bool usdtolbp;

  const Offer({
    required this.usdAmount,
    required this.rate,
    required this.usdtolbp,
  });
}
