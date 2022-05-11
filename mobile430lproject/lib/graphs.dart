import 'package:flutter/material.dart';
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
    ));
  }
}
