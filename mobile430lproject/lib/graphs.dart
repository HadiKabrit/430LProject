import 'package:flutter/material.dart';
import 'package:mobile430lproject/constants.dart';
import 'package:mobile430lproject/navdrawer.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Buy USD Rate",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Inria Serif',
                      )),
                  style: ButtonStyle(
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
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Sell USD Rate",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Inria Serif',
                      )),
                  style: ButtonStyle(
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
            Container(
              height: 0.7 * size.height,
              width: size.width,
              child: Column(children: [
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
                Text("Graph"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
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
                      onPressed: () {},
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
                      onPressed: () {},
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
