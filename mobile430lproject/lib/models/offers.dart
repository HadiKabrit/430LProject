import 'dart:ffi';

class Offers {
  final double usdAmount;
  final double rate;
  final bool usdtolbp;
  final String addedDate;
  final String phoneNumber;
  final int id;
  final int userID;

  const Offers({
    required this.usdAmount,
    required this.rate,
    required this.usdtolbp,
    required this.addedDate,
    required this.phoneNumber,
    required this.id,
    required this.userID,
  });
  factory Offers.fromJson(Map<String, dynamic> json) {
    return Offers(
      usdAmount: json['usd_amount'],
      rate: json['rate'],
      usdtolbp: json['usd_to_lbp'],
      addedDate: json['added_date'],
      phoneNumber: json['phone'],
      id: json['id'],
      userID: json['user_id'],
    );
  }
}
