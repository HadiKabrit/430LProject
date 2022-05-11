import 'dart:ffi';

class Transactions {
  final double usdAmount;
  final double lbpAmount;
  final bool usdtolbp;
  final String addedDate;
  final int userID;

  const Transactions({
    required this.usdAmount,
    required this.lbpAmount,
    required this.usdtolbp,
    required this.addedDate,
    required this.userID,
  });
  factory Transactions.fromJson(Map<String, dynamic> json) {
    return Transactions(
      usdAmount: json['usd_amount'],
      lbpAmount: json['lbp_amount'],
      usdtolbp: json['usd_to_lbp'],
      addedDate: json['added_date'],
      userID: json['user_id'],
    );
  }
}
