import 'package:flutter/material.dart';
import 'package:mobile430lproject/displayMyOffers/MyOffersPage.dart';
import 'package:mobile430lproject/displayOffers/offersPage.dart';
import 'package:mobile430lproject/graphs.dart';
import 'package:mobile430lproject/login.dart';
import 'package:mobile430lproject/register.dart';
import 'package:mobile430lproject/displayTransactions/user_transactions.dart';

import 'package:mobile430lproject/wrapper.dart';

import 'home_screen.dart';
import 'landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Wrapper(),
        '/Home': (context) => const HomeScreen(),
        '/Landing': (context) => const LandingScreen(),
        '/SignIn': (context) => const SignIn(),
        '/Register': (context) => const SignUp(),
        '/Transactions': (context) => const UserTransactions(),
        '/Offers': (context) => const OffersPage(),
        '/Graphs': (context) => const GraphPage(),
        '/MyOffers': (context) => const MyOffersPage(),
      },
    );
  }
}
