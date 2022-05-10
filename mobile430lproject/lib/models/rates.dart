import 'dart:ffi';

class Rates {
  final double buyRate;
  final double sellRate;

  const Rates({
    required this.buyRate,
    required this.sellRate,
  });

  factory Rates.fromJson(Map<String, dynamic> json) {
    return Rates(
      buyRate: json['lbp_to_usd'],
      sellRate: json['usd_to_lbp'],
    );
  }
}
