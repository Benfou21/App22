import 'package:flutter/material.dart';

import 'utils/Capsul.dart';
import 'utils/constants.dart';
import 'utils/functions.dart';
import 'package:widget_mask/widget_mask.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome_screen extends StatefulWidget {
  const Welcome_screen({Key? key}) : super(key: key);

  @override
  State<Welcome_screen> createState() => _Welcome_screenState();
}

class _Welcome_screenState extends State<Welcome_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.4, 0.9],
                colors: [kOrange_main4, kOrange_main3])),
        child: Column(
          children: [
            addVerticalSpace(150),
            Center(
              child: Hero(
                tag: "logo",
                child: WidgetMask(
                  blendMode: BlendMode.srcATop,
                  childSaveLayer: true,
                  mask: Image.asset(
                    "images/image2.jpg",
                    fit: BoxFit.cover,
                    alignment: Alignment.centerLeft,
                  ),
                  child: Image.asset(
                    "images/ovale2.png",
                    scale: 1.7,
                  ),
                ),
              ),
            ),
            addVerticalSpace(100),
            Text(
              "Relive your trips and discover the others!",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(textStyle: kHeadline1),
            ),
            addVerticalSpace(120),
            Capsul(
              text: "Get Started",
              onpressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
