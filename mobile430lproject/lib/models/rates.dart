import 'dart:ffi';

class Rates {
  final double buyRate;
  final double sellRate;
  final double buyFluct;
  final double sellFluct;

  const Rates({
    required this.buyRate,
    required this.sellRate,
    required this.buyFluct,
    required this.sellFluct,
  });

  factory Rates.fromJson(Map<String, dynamic> json) {
    return Rates(
      buyRate: json['lbp_to_usd'],
      sellRate: json['usd_to_lbp'],
      buyFluct: json['buy_fluct'],
      sellFluct: json['sell_fluct'],
    );
  }
}
