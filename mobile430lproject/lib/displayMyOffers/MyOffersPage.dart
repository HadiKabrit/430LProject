import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile430lproject/constants.dart';
import 'package:mobile430lproject/displayMyOffers/myOfferTile.dart';
import 'package:mobile430lproject/displayOffers/offerTile.dart';
import 'package:mobile430lproject/login.dart';
import 'package:mobile430lproject/models/offer.dart';
import 'package:mobile430lproject/models/offers.dart';
import 'package:mobile430lproject/navdrawer.dart';
import 'package:http/http.dart' as http;

class MyOffersPage extends StatefulWidget {
  const MyOffersPage({Key? key}) : super(key: key);

  @override
  State<MyOffersPage> createState() => _MyOffersPageState();
}

enum calcType { buy, sell }

Future<List<Offers>> fetchMyOffers() async {
  String? token = await storage.read(key: "token");
  var response = await http.get(
    Uri.parse('$apiURL/offer/list/0/50'),
    headers: {'Authorization': 'Bearer $token'},
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

class _MyOffersPageState extends State<MyOffersPage> {
  late Future futureOffers;

  @override
  void initState() {
    super.initState();
    futureOffers = fetchMyOffers();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return const CircularProgressIndicator();
              } else {
                List<Offers> offersList = snapshot.data as List<Offers>;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // OffersListWidget(offersList: offersList),
                      MyOffersListWidget(offersList: offersList),
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

class MyOffersListWidget extends StatefulWidget {
  final List<Offers> offersList;

  const MyOffersListWidget({Key? key, required this.offersList})
      : super(key: key);

  @override
  State<MyOffersListWidget> createState() => _MyOffersListWidgetState();
}

class _MyOffersListWidgetState extends State<MyOffersListWidget> {
  Widget mappingFunction(Offers offer) {
    return MyOfferTile(
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
