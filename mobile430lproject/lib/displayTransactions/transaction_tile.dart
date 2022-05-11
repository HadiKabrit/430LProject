import 'package:flutter/material.dart';
import 'package:mobile430lproject/constants.dart';
import 'package:mobile430lproject/models/transactionss.dart';

class TransactionTile extends StatefulWidget {
  final Transactions transaction;
  const TransactionTile({Key? key, required this.transaction})
      : super(key: key);

  @override
  State<TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
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
                  widget.transaction.usdtolbp == true ? "Sell USD" : "Buy USD",
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
                    text: '${widget.transaction.usdAmount} USD',
                    style: TextStyle(color: primaryBlue, fontSize: 16),
                  ),
                  TextSpan(
                    text: ' LBP Amount: ',
                    style: TextStyle(color: darkBlue, fontSize: 20),
                  ),
                  TextSpan(
                    text: '${widget.transaction.lbpAmount} LBP',
                    style: TextStyle(color: primaryBlue, fontSize: 16),
                  ),
                  TextSpan(
                    text: 'Date Added',
                    style: TextStyle(color: darkBlue, fontSize: 20),
                  ),
                  TextSpan(
                    text: widget.transaction.addedDate,
                    style: TextStyle(color: primaryBlue, fontSize: 16),
                  )
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
