import 'package:flutter/material.dart';
import 'package:mobile430lproject/home_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<CustomUser?>(context, listen: true);
    // return either the Home or Authenticate widget
    // if (user == null) {
    return const HomeScreen();
    // } else {
    //   return const HomeScreen();
    // }
  }
}
