import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile430lproject/constants.dart';
import 'package:mobile430lproject/displayTransactions/transaction_tile.dart';
import 'package:mobile430lproject/login.dart';
import 'package:mobile430lproject/models/transactions.dart';
import 'package:mobile430lproject/models/transactionss.dart';
import 'package:mobile430lproject/navdrawer.dart';
import 'package:http/http.dart' as http;

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

Future<List<Transactions>> fetchTransactions() async {
  String? token = await storage.read(key: "token");
  var response = await http.get(
    Uri.parse('$apiURL/transaction'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.body.isNotEmpty) {
    // Rates.fromJson(jsonDecode(response.body));
    List data = json.decode(response.body);

    List<Transactions> transactionsList = [];

    for (int i = 0; i < data.length; i++) {
      Transactions T = Transactions.fromJson(data[i]);
      transactionsList.add(T);
    }
    return transactionsList;
  }
  return [];
}

class _UserTransactionsState extends State<UserTransactions> {
  late Future futureTransactions;

  @override
  void initState() {
    super.initState();
    futureTransactions = fetchTransactions();
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
          future: futureTransactions,
          builder: (context, snapshot) {
            List<Transactions> transactionsList =
                snapshot.data as List<Transactions>;

            print(transactionsList);
            return SingleChildScrollView(
              child: Column(
                children: [
                  transactionListWidget(transactionList: transactionsList),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class transactionListWidget extends StatefulWidget {
  final List<Transactions> transactionList;

  const transactionListWidget({Key? key, required this.transactionList})
      : super(key: key);

  @override
  State<transactionListWidget> createState() => _transactionListWidgetState();
}

class _transactionListWidgetState extends State<transactionListWidget> {
  Widget mappingFunction(Transactions transaction) {
    return TransactionTile(
      transaction: transaction,
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
          children: widget.transactionList.map(mappingFunction).toList(),
        ),
      ],
    );
  }
}
