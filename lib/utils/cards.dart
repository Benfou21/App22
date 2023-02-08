import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app22/repositeries.dart/repository.dart';
import 'package:app22/model/B3_selection.dart';
import 'RoundedButton.dart';
import 'showPicker.dart';

class B3_card extends StatelessWidget {
  const B3_card({Key? key, required this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ref, child) {
        B3_selection b3 = ref.watch(currentB3);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RoundedButton(
            colour: Colors.white,
            title: "${b3.name} : ${b3.titles[b3.value]}",
            coleurText: Colors.black,
            onPressed: () {
              showPickerIcons(context, scaffoldKey, ref, b3);
            },
          ),
        );
      }),
    );
  }
}

class SlideCards extends StatefulWidget {
  SlideCards({required this.colour});

  final Color colour;

  @override
  State<SlideCards> createState() => _SlideCardsState();
}

class _SlideCardsState extends State<SlideCards> {
  double water = 0;

  double cofee = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
      child: Material(
          color: widget.colour,
          borderRadius: BorderRadius.circular(30.0),
          elevation: 5.0,
          child: Consumer(
            builder: (context, ref, child) {
              return Column(
                children: [
                  const Text("Brevage"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Eau"),
                      Slider(
                        value: water,
                        onChanged: (newvalue) {
                          setState(() {
                            water = newvalue;
                          });
                        },
                        divisions: 3,
                        min: 0,
                        max: 3,
                      ),
                      const Icon(Icons.water_drop),
                      Text("{* $water}")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Café"),
                      Slider(
                        value: cofee,
                        onChanged: (newvalue) {
                          setState(() {
                            cofee = newvalue;
                          });
                        },
                        divisions: 3,
                        min: 0,
                        max: 3,
                      ),
                      const Icon(Icons.coffee),
                      Text("{* $cofee}")
                    ],
                  )
                ],
              );
            },
          )),
    );
  }
}

class CustomSlider extends StatefulWidget {
  CustomSlider({super.key});
  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  String text = "faible";

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        B3_selection b3 = ref.watch(currentB3);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(b3.name),
            Slider(
              value: b3.value.toDouble(),
              onChanged: (newvalue) {
                setState(() {
                  b3.value = newvalue.round();

                  switch (newvalue.round()) {
                    case 0:
                      text = b3.titles[0];
                      break;
                    case 1:
                      text = b3.titles[1];
                      break;
                    case 2:
                      text = b3.titles[2];
                      break;

                    default:
                  }
                });
              },
              divisions: 2,
              min: 0,
              max: 2,
            ),
            Icon(b3.icon),
            Text(text)
          ],
        );
      },
    );
  }
}

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool state = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        B3_selection selection = ref.watch(currentB3);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(selection.name),
            Checkbox(
              value: state,
              onChanged: (bool? newValue) {
                setState(() {
                  state = newValue!;
                  switch (state) {
                    case true:
                      selection.value = 1;
                      break;
                    case false:
                      selection.value = 0;
                      break;
                    default:
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }
}
