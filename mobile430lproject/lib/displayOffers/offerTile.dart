import 'package:flutter/material.dart';
import 'package:mobile430lproject/constants.dart';
import 'package:mobile430lproject/models/offers.dart';
import 'package:mobile430lproject/models/transactionss.dart';

class OfferTile extends StatefulWidget {
  final Offers offer;
  const OfferTile({Key? key, required this.offer}) : super(key: key);

  @override
  State<OfferTile> createState() => _OfferTileState();
}

class _OfferTileState extends State<OfferTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          color: Colors.grey[200],
          margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                  widget.offer.usdtolbp == true ? "Sell USD" : "Buy USD",
                  style: TextStyle(color: primaryBlue, fontSize: 26)),
            ),
            // subtitle: Text('Carbs: ${food.carbs}g'),
            subtitle: RichText(
              // overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              maxLines: 3,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'USD Amount: ',
                    style: TextStyle(color: darkBlue, fontSize: 20),
                  ),
                  TextSpan(
                    text: '${widget.offer.usdAmount} USD',
                    style: TextStyle(color: primaryBlue, fontSize: 16),
                  ),
                  TextSpan(
                    text: 'Rate: ',
                    style: TextStyle(color: darkBlue, fontSize: 20),
                  ),
                  TextSpan(
                    text: '${widget.offer.rate} LBP',
                    style: TextStyle(color: primaryBlue, fontSize: 16),
                  ),
                  TextSpan(
                    text: 'Phone Number: ',
                    style: TextStyle(color: darkBlue, fontSize: 20),
                  ),
                  TextSpan(
                    text: widget.offer.phoneNumber,
                    style: TextStyle(color: primaryBlue, fontSize: 16),
                  ),
                  TextSpan(
                    text: 'Date Added: ',
                    style: TextStyle(color: darkBlue, fontSize: 20),
                  ),
                  TextSpan(
                    text: widget.offer.addedDate,
                    style: TextStyle(color: primaryBlue, fontSize: 16),
                  ),
                ],
              ),
            ),
            // trailing: Text(""),
          ),
        ),
      ),
    );
  }
}
