import 'package:flutter/cupertino.dart';

class B3_selection {
  final String name; //default : ""
  int value; // 0 : rien (default), 1 : faible, 2: moyen, 3 : fort
  IconData icon;
  List<String> titles;

  B3_selection(
      {this.value = 0,
      required this.name,
      required this.icon,
      required this.titles});
}
