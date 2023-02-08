import 'package:flutter/material.dart';
import 'package:app22/repositeries.dart/auth_methods.dart';

class StyleButton1 extends StatelessWidget {
  const StyleButton1(this.route, this.text, {Key? key}) : super(key: key);
  final String route;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.all(15),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: Colors.red),
          ),
        ),
      ),
      onPressed: () {
        AuthMethods().signOut();
        Navigator.of(context).pushNamed(route);
      },
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
