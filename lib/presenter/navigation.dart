import 'package:flutter/material.dart';
import 'package:flutter_app/view/flowers_screen.dart';
import 'package:flutter_app/view/sellers_screen.dart';

class Navigation {
  static void goToSellersMode(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SellersScreen()));
  }

  static void goToFlowersScreen(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => FlowersScreen()));
  }
}
