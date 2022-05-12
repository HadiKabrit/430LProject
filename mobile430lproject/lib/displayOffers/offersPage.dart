import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile430lproject/constants.dart';
import 'package:mobile430lproject/displayOffers/offerTile.dart';
import 'package:mobile430lproject/models/offers.dart';
import 'package:mobile430lproject/navdrawer.dart';
import 'package:http/http.dart' as http;

class OffersPage extends StatefulWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  State<OffersPage> createState() => _OffersPageState();
}

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

class _OffersPageState extends State<OffersPage> {
  late Future futureOffers;

  @override
  void initState() {
    super.initState();
    futureOffers = fetchOffers();
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
        ),
        body: FutureBuilder(
          future: futureOffers,
          builder: (context, snapshot) {
            List<Offers> offersList = snapshot.data as List<Offers>;

            // print(offersList);
            return SingleChildScrollView(
              child: Column(
                children: [
                  // OffersListWidget(offersList: offersList),
                  OffersListWidget(offersList: offersList),
                ],
              ),
            );
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
