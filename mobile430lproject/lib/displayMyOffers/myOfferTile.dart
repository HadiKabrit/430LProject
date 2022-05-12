import 'package:flutter/material.dart';
import 'package:mobile430lproject/constants.dart';
import 'package:mobile430lproject/models/offers.dart';
import 'package:mobile430lproject/models/transactionss.dart';

class MyOfferTile extends StatefulWidget {
  final Offers offer;
  const MyOfferTile({Key? key, required this.offer}) : super(key: key);

  @override
  State<MyOfferTile> createState() => _MyOfferTileState();
}

class _MyOfferTileState extends State<MyOfferTile> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    // overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'USD Amount: ',
                        style: TextStyle(color: darkBlue, fontSize: 20),
                      ),
                      TextSpan(
                        text: '${widget.offer.usdAmount} USD',
                        style: TextStyle(color: primaryBlue, fontSize: 16),
                      )
                    ])),
                RichText(
                    // overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'Rate: ',
                        style: TextStyle(color: darkBlue, fontSize: 20),
                      ),
                      TextSpan(
                        text: '${widget.offer.rate} LBP/1USD',
                        style: TextStyle(color: primaryBlue, fontSize: 16),
                      )
                    ])),
                RichText(
                    // overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'Phone Number: ',
                        style: TextStyle(color: darkBlue, fontSize: 20),
                      ),
                      TextSpan(
                        text: '+961 ${widget.offer.phoneNumber}',
                        style: TextStyle(color: primaryBlue, fontSize: 16),
                      )
                    ])),
                RichText(
                  // overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Date Added: ',
                        style: TextStyle(color: darkBlue, fontSize: 20),
                      ),
                      TextSpan(
                        text: '${widget.offer.addedDate}',
                        style: TextStyle(color: primaryBlue, fontSize: 16),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.01 * size.height,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Decline",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Inria Serif',
                          )),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(size.width * 0.25, 45)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primaryBlue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Accept",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Inria Serif',
                          )),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(size.width * 0.25, 45)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primaryBlue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                  ],
                )
              ],
            ),
            // trailing: Text(""),
          ),
        ),
      ),
    );
  }
}
