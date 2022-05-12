import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile430lproject/constants.dart';

import 'package:mobile430lproject/login.dart';
import 'package:mobile430lproject/models/rates.dart';
import 'package:mobile430lproject/models/transactions.dart';
import 'package:mobile430lproject/navdrawer.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum calcType { buy, sell }

Future<Rates> fetchRates() async {
  var response = await http.get(
    Uri.parse('$apiURL/exchangeRate'),
  );
  if (response.statusCode == 200) {
    return Rates.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Rates');
  }
}

Future<void> addTransaction(Transaction transaction) async {
  try {
    String? token = await storage.read(key: "token");
    if (token != "") {
      var response = await http.post(Uri.parse('$apiURL/transaction'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(
            {
              'usd_amount': transaction.usdAmount,
              'lbp_amount': transaction.lbpAmount,
              'usd_to_lbp': transaction.usdtolbp
            },
          ));
      if (response.body.isNotEmpty) {
        var data = json.decode(response.body);
        print(data);
      }
    } else {
      var response = await http.post(Uri.parse('$apiURL/transaction'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(
            {
              'usd_amount': transaction.usdAmount,
              'lbp_amount': transaction.lbpAmount,
              "usd_to_lbp": transaction.usdtolbp
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

class _HomeScreenState extends State<HomeScreen> {
  late Future<Rates> futureRates;
  late Future<double> numberToBeCalc;

  @override
  void initState() {
    super.initState();
    futureRates = fetchRates();
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
          String lbpAmount = '';

          void onChangedUSDAmount(val) {
            usdAmount = val;
          }

          void onChangedLBPAmount(val) {
            lbpAmount = val;
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
                    'Add Transaction',
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
                    onChanged: (val) => onChangedLBPAmount(val),
                    decoration:
                        const InputDecoration(hintText: "Enter LBP Amount"),
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
                    Transaction transaction = Transaction(
                        usdAmount: double.parse(usdAmount),
                        lbpAmount: double.parse(lbpAmount),
                        usdtolbp: usdtolbp);

                    await addTransaction(transaction);
                    setState(() {
                      futureRates = fetchRates();
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

  calcType? _calctype = calcType.buy;
  double? numberToBeConverted = 0.0;
  double? buyRate = 0.0;
  double? sellRate = 0.0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final TextEditingController _textEditingController =
        TextEditingController();

    void onChangedAmount(val) {
      numberToBeConverted = val;
    }

    void getBuyRate(val) {
      buyRate = val;
    }

    void getSellRate(val) {
      sellRate = val;
    }

    return SafeArea(
        child: Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        toolbarHeight: 0.075 * size.height,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF65AFC1),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 0.35 * size.height,
              width: size.width,
              color: const Color(0xffffffff),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Exchange Rate",
                    style: TextStyle(
                        color: darkBlue,
                        fontSize: 48,
                        fontFamily: "Inria Serif"),
                  ),
                  SizedBox(height: 0.05 * size.height),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Buy Rate",
                            style: TextStyle(
                                color: primaryBlue,
                                fontSize: 36,
                                fontFamily: "Inria Serif"),
                          ),
                          FutureBuilder<Rates>(
                            future: futureRates,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.buyRate == null) {
                                  return const CircularProgressIndicator();
                                } else {
                                  buyRate = snapshot.data!.buyRate;
                                  getBuyRate(buyRate);
                                  return Column(
                                    children: [
                                      Text(
                                        snapshot.data!.buyRate.toString(),
                                        style: TextStyle(
                                            color: darkBlue,
                                            fontSize: 32,
                                            fontFamily: "Inria Serif"),
                                      ),
                                      Text(
                                        '${((snapshot.data!.buyFluct * 100).round()) / 100} %',
                                        style: TextStyle(
                                            color: darkBlue,
                                            fontSize: 28,
                                            fontFamily: "Inria Serif"),
                                      ),
                                    ],
                                  );
                                }
                              } else if (snapshot.hasError) {
                                return Text('Not Set Yet');
                              }

                              return const CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Sell Rate",
                            style: TextStyle(
                                color: primaryBlue,
                                fontSize: 36,
                                fontFamily: "Inria Serif"),
                          ),
                          FutureBuilder<Rates>(
                            future: futureRates,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.buyRate == null) {
                                  return const CircularProgressIndicator();
                                } else {
                                  sellRate = snapshot.data!.sellRate;
                                  getSellRate(sellRate);
                                  return Column(
                                    children: [
                                      Text(
                                        snapshot.data!.sellRate.toString(),
                                        style: TextStyle(
                                            color: darkBlue,
                                            fontSize: 32,
                                            fontFamily: "Inria Serif"),
                                      ),
                                      Text(
                                        '${((snapshot.data!.sellFluct * 100).round()) / 100} %',
                                        style: TextStyle(
                                            color: darkBlue,
                                            fontSize: 28,
                                            fontFamily: "Inria Serif"),
                                      ),
                                    ],
                                  );
                                }
                              } else if (snapshot.hasError) {
                                return Text("Not Set Yet");
                              }

                              return const CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.02 * size.height,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 0.75 * size.width,
                      ),
                      RawMaterialButton(
                        onPressed: () async {
                          await showInformationDialog(context);
                        },
                        elevation: 2.0,
                        fillColor: primaryBlue,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 35.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 0.5 * size.height,
              width: size.width,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    // spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
                color:
                    // Colors.black,
                    const Color(0xfffbfbfbfb),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 0.03 * size.height,
                  ),
                  Text(
                    "Calculator",
                    style: TextStyle(
                        color: darkBlue,
                        fontSize: 48,
                        fontFamily: "Inria Serif"),
                  ),
                  SizedBox(
                    height: 0.02 * size.height,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          if (value == "") {
                            numberToBeConverted = 0.0;
                          } else {
                            numberToBeConverted = double.parse(value);
                          }
                        });
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        hintText: "Input Amount to be converted",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.02 * size.height,
                  ),
                  ListTile(
                    title: Text(
                      'Buy',
                      style: TextStyle(
                          color: darkBlue,
                          fontSize: 32,
                          fontFamily: "Inria Serif"),
                    ),
                    leading: Radio<calcType>(
                      value: calcType.buy,
                      groupValue: _calctype,
                      onChanged: (calcType? value) {
                        setState(() {
                          _calctype = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Sell',
                      style: TextStyle(
                          color: darkBlue,
                          fontSize: 32,
                          fontFamily: "Inria Serif"),
                    ),
                    leading: Radio<calcType>(
                      value: calcType.sell,
                      groupValue: _calctype,
                      onChanged: (calcType? value) {
                        setState(() {
                          _calctype = value;
                        });
                      },
                    ),
                  ),
                  Text(
                    "Result",
                    style: TextStyle(
                        color: darkBlue,
                        fontSize: 48,
                        fontFamily: "Inria Serif"),
                  ),
                  _calctype == calcType.buy
                      ? Text(
                          // buyRate.toString()

                          (((buyRate! * numberToBeConverted!) * 100).round() /
                                      100)
                                  .toString() +
                              " LBP",
                          style: TextStyle(
                              color: darkBlue,
                              fontSize: 32,
                              fontFamily: "Inria Serif"),
                        )
                      : Text(
                          (((sellRate! * numberToBeConverted!) * 100).round() /
                                      100)
                                  .toString() +
                              " LBP",
                          style: TextStyle(
                              color: darkBlue,
                              fontSize: 32,
                              fontFamily: "Inria Serif"),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
