import 'package:flutter/material.dart';

class LineDivider extends StatelessWidget {
  const LineDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      indent: 20,
      endIndent: 20,
      thickness: 2,
      height: 0,
      color: Colors.black,
    );
  }
}
