import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile430lproject/constants.dart';
import 'package:mobile430lproject/lineChart.dart';
import 'package:mobile430lproject/models/points.dart';
import 'package:mobile430lproject/navdrawer.dart';
import 'package:http/http.dart' as http;

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  State<GraphPage> createState() => _GraphPageState();
}

String buyOrSell = "usd_to_lbp";

String timePeriod = "1day";

Future<List<Point>> fetchPoints() async {
  // String? token = await storage.read(key: "token");
  var response = await http.get(
    Uri.parse('$apiURL/graph/${buyOrSell}/${timePeriod}'),
  );

  List data = json.decode(response.body);

  if (response.body.isNotEmpty) {
    // Rates.fromJson(jsonDecode(response.body));

    print(data);
    List<Point> pointsList = [];

    for (int i = 0; i < data.length; i++) {
      Point p = Point(X: data[i][0], Y: data[i][1]);
      pointsList.add(p);
    }

    return pointsList;
  }
  return [];
}

class _GraphPageState extends State<GraphPage> {
  late Future futurePoints;

  @override
  void initState() {
    super.initState();
    futurePoints = fetchPoints();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: primaryBlue,
      drawer: NavDrawer(),
      appBar: AppBar(
        toolbarHeight: 0.075 * size.height,
        backgroundColor: primaryBlue,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Graphs",
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontFamily: "Inria Serif"),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      buyOrSell = "lbp_to_usd";
                      futurePoints = fetchPoints();
                    });
                  },
                  child: const Text("Buy USD Rate",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Inria Serif',
                        color: Colors.white,
                      )),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(size.width * 0.4, 55)),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.white)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryBlue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      buyOrSell = "usd_to_lbp";
                      futurePoints = fetchPoints();
                    });
                  },
                  child: const Text("Sell USD Rate",
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Inria Serif',
                          color: Colors.white)),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.white)),
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(size.width * 0.4, 55)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryBlue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 0.02 * size.height,
            ),
            Container(
              height: 0.8 * size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color:
                    // Colors.black,
                    Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(children: [
                SizedBox(
                  height: 0.05 * size.height,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text("High",
                            style: TextStyle(
                              color: darkBlue,
                              fontSize: 22,
                              fontFamily: 'Inria Serif',
                            )),
                        Text("28000 LL",
                            style: TextStyle(
                              color: primaryBlue,
                              fontSize: 22,
                              fontFamily: 'Inria Serif',
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Low",
                            style: TextStyle(
                              color: darkBlue,
                              fontSize: 22,
                              fontFamily: 'Inria Serif',
                            )),
                        Text("26000 LL",
                            style: TextStyle(
                              color: primaryBlue,
                              fontSize: 22,
                              fontFamily: 'Inria Serif',
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Average",
                            style: TextStyle(
                              color: darkBlue,
                              fontSize: 22,
                              fontFamily: 'Inria Serif',
                            )),
                        Text("27000 LL",
                            style: TextStyle(
                              color: primaryBlue,
                              fontSize: 22,
                              fontFamily: 'Inria Serif',
                            )),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.05 * size.height,
                ),
                FutureBuilder(
                  future: futurePoints,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      } else {
                        List<Point> pointsList = snapshot.data as List<Point>;

                        // print(offersList);
                        return LineChart(pointsList: pointsList);
                      }
                    } else if (snapshot.hasError) {
                      return Text('Not Set Yet');
                    }

                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
                SizedBox(
                  height: 0.05 * size.height,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          timePeriod = "1day";
                          futurePoints = fetchPoints();
                        });
                      },
                      child: const Text("1D",
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
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          timePeriod = "5days";
                          futurePoints = fetchPoints();
                        });
                      },
                      child: const Text("5D",
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
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          timePeriod = "30days";
                          futurePoints = fetchPoints();
                        });
                      },
                      child: const Text("MAX",
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
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    ));
  }
}
