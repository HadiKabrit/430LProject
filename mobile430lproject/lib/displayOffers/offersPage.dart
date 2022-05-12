import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile430lproject/constants.dart';
import 'package:mobile430lproject/displayOffers/offerTile.dart';
import 'package:mobile430lproject/login.dart';
import 'package:mobile430lproject/models/offer.dart';
import 'package:mobile430lproject/models/offers.dart';
import 'package:mobile430lproject/navdrawer.dart';
import 'package:http/http.dart' as http;

class OffersPage extends StatefulWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  State<OffersPage> createState() => _OffersPageState();
}

enum calcType { buy, sell }

Future<List<Offers>> fetchOffers() async {
  // String? token = await storage.read(key: "token");
  var response = await http.get(
    Uri.parse('$apiURL/offer/list/0/10'),
  );

  List data = json.decode(response.body);

  if (response.body.isNotEmpty) {
    // Rates.fromJson(jsonDecode(response.body));

    print(data);
    List<Offers> offersList = [];

    for (int i = 0; i < data.length; i++) {
      Offers O = Offers.fromJson(data[i]);
      offersList.add(O);
    }

    return offersList;
  }
  return [];
}

Future<void> addOffer(Offer offer) async {
  try {
    String? token = await storage.read(key: "token");
    if (token != "") {
      var response = await http.post(Uri.parse('$apiURL/offer'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(
            {
              'usd_amount': offer.usdAmount,
              'rate': offer.rate,
              'usd_to_lbp': offer.usdtolbp
            },
          ));
      if (response.body.isNotEmpty) {
        var data = json.decode(response.body);
        print(data);
      }
    }
  } catch (error) {
    print(error.toString());
  }
}

class _OffersPageState extends State<OffersPage> {
  late Future futureOffers;

  @override
  void initState() {
    super.initState();
    futureOffers = fetchOffers();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> showInformationDialog(BuildContext context) async {
    final Size size = MediaQuery.of(context).size;
    return await showDialog(
        context: context,
        builder: (context) {
          calcType? calctype1 = calcType.buy;
          final TextEditingController _textEditingController1 =
              TextEditingController();
          final TextEditingController _textEditingController2 =
              TextEditingController();

          String usdAmount = '';
          String rateAmount = '';

          void onChangedUSDAmount(val) {
            usdAmount = val;
          }

          void onChangedRateAmount(val) {
            rateAmount = val;
          }

          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 0.02 * size.height,
                  ),
                  Text(
                    'Add Offer',
                    style: TextStyle(
                        color: darkBlue,
                        fontSize: 36,
                        fontFamily: "Inria Serif"),
                  ),
                  SizedBox(
                    height: 0.03 * size.height,
                  ),
                  TextFormField(
                    validator: (value) {
                      return value!.isNotEmpty ? null : "Invalid Field";
                    },
                    onChanged: (val) => onChangedUSDAmount(val),
                    decoration:
                        const InputDecoration(hintText: "Enter USD Amount"),
                    controller: _textEditingController1,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  SizedBox(
                    height: 0.02 * size.height,
                  ),
                  TextFormField(
                    validator: (value) {
                      return value!.isNotEmpty ? null : "Invalid Field";
                    },
                    onChanged: (val) => onChangedRateAmount(val),
                    decoration: const InputDecoration(hintText: "Enter Rate"),
                    controller: _textEditingController2,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  SizedBox(
                    height: 0.03 * size.height,
                  ),
                  StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Buy USD',
                            style: TextStyle(
                                color: darkBlue,
                                fontSize: 28,
                                fontFamily: "Inria Serif"),
                          ),
                          leading: Radio<calcType>(
                            value: calcType.buy,
                            groupValue: calctype1,
                            onChanged: (calcType? value) {
                              setState(() {
                                calctype1 = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Sell USD',
                            style: TextStyle(
                                color: darkBlue,
                                fontSize: 28,
                                fontFamily: "Inria Serif"),
                          ),
                          leading: Radio<calcType>(
                            value: calcType.sell,
                            groupValue: calctype1,
                            onChanged: (calcType? value) {
                              setState(() {
                                calctype1 = value;
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    var usdtolbp = false;
                    if (calctype1 == calcType.sell) {
                      usdtolbp = true;
                    } else if (calctype1 == calcType.buy) {
                      usdtolbp = false;
                    }
                    Offer offer = Offer(
                        usdAmount: double.parse(usdAmount),
                        rate: double.parse(rateAmount),
                        usdtolbp: usdtolbp);
                    //  Transaction(
                    //     usdAmount: double.parse(usdAmount),
                    //     lbpAmount: double.parse(lbpAmount),
                    //     usdtolbp: usdtolbp);

                    await addOffer(offer);
                    setState(() {
                      futureOffers = fetchOffers();
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Add",
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Inria Serif',
                      )),
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(314, 70)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryBlue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: NavDrawer(),
        appBar: AppBar(
          toolbarHeight: 0.075 * size.height,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Color(0xFF65AFC1),
          ),
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Daily Log"),
          ),
          centerTitle: true,
          actions: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    String? token = await storage.read(key: "token");
                    if (token != "") {
                      Navigator.pushNamed(context, "/MyOffers");
                    }
                  },
                  child: const Text("My Offers",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Inria Serif',
                      )),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(size.width * 0.25, 45)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryBlue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                  onPressed: () async {
                    await showInformationDialog(context);
                  },
                  child: const Text("Add Offer",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Inria Serif',
                      )),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(size.width * 0.25, 45)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryBlue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
        body: FutureBuilder(
          future: futureOffers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return const CircularProgressIndicator();
              } else {
                List<Offers> offersList = snapshot.data as List<Offers>;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // OffersListWidget(offersList: offersList),
                      OffersListWidget(offersList: offersList),
                    ],
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return Text("Not Available");
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class OffersListWidget extends StatefulWidget {
  final List<Offers> offersList;

  const OffersListWidget({Key? key, required this.offersList})
      : super(key: key);

  @override
  State<OffersListWidget> createState() => _OffersListWidgetState();
}

class _OffersListWidgetState extends State<OffersListWidget> {
  Widget mappingFunction(Offers offer) {
    return OfferTile(
      offer: offer,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 0.02 * size.height,
        ),
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          // scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: widget.offersList.map(mappingFunction).toList(),
        ),
      ],
    );
  }
}
