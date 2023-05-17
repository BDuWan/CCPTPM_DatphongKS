import 'package:flutter/material.dart';

class Helper {
  static void nextPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}