import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_picker/flutter_picker.dart';
import 'package:app22/model/B3_selection.dart';
import 'package:app22/repositeries.dart/repository.dart';

//B3
showPickerIcons(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey,
    WidgetRef ref, B3_selection b3) {
  Picker(
      adapter: PickerDataAdapter(data: [
        PickerItem(text: const Icon(Icons.face), value: 0, children: [
          PickerItem(
            text: const Text("Faible"),
            value: 1,
          ),
        ]),
        PickerItem(text: const Icon(Icons.face), value: 1, children: [
          PickerItem(
            text: const Text("Moyen"),
            value: 2,
          ),
        ]),
        PickerItem(text: const Icon(Icons.face), value: 2, children: [
          PickerItem(
            text: const Text("Fort"),
            value: 3,
          ),
        ]),
      ]),
      title: const Text("Select Icon"),
      onConfirm: (Picker picker, List value) {
        final pickedValue = picker.getSelectedValues()[0];

        ref.read(B3SelectionProvider.notifier).change(pickedValue, b3);
        b3.value = pickedValue;
      }).show(scaffoldKey.currentState!);
}

// //Repas
// showPickerRepas(
//     BuildContext context, GlobalKey<ScaffoldState> scaffoldKey, WidgetRef ref) {
//   Picker(
//       adapter: PickerDataAdapter(data: [
//         PickerItem(
//             //equilibré
//             text: const Icon(Icons.health_and_safety),
//             value: 1,
//             children: [
//               PickerItem(
//                 text: const Text("Faible"),
//                 value: 1,
//               ),
//               PickerItem(
//                 text: const Text("Moyen"),
//                 value: 2,
//               ),
//               PickerItem(
//                 text: const Text("Bien"),
//                 value: 3,
//               ),
//             ]),
//         PickerItem(
//             //qualité
//             text: const Icon(Icons.high_quality),
//             value: 2,
//             children: [
//               PickerItem(
//                 text: const Text("Faible"),
//                 value: 1,
//               ),
//               PickerItem(
//                 text: const Text("Moyen"),
//                 value: 2,
//               ),
//               PickerItem(
//                 text: const Text("Bien"),
//                 value: 3,
//               ),
//             ]),
//       ]),
//       title: const Text("Select Icon"),
//       onConfirm: (Picker picker, List value) {
//         final pickedValue = picker.getSelectedValues();

//         ref
//             .read(B3SelectionProvider.notifier)
//             .change(pickedValue[0], B3_selection(name: "Repas equilibe"));
//         ref
//             .read(B3SelectionProvider.notifier)
//             .change(pickedValue[1], B3_selection(name: "Repas quantite"));

//         //ref.read(RepasProvider.notifier).change(pickedValue[0], pickedValue[1]);

//         print(pickedValue);
//       }).show(scaffoldKey.currentState!);
// }
