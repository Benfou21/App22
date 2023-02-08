import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riverpod/riverpod.dart';
import 'package:app22/model/B3_selection.dart';
import 'package:app22/model/sendState.dart';
import 'package:app22/model/user.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:app22/utils/functions.dart';
import 'auth_methods.dart';

final UserProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<User> {
  UserNotifier()
      : super(const User(username: "null", uid: "null", email: "null"));
}

final currentB3 = Provider<B3_selection>((ref) => throw UnimplementedError());

final counter = StateProvider((ref) => 0);

final SendStateProvider =
    StateNotifierProvider<SendStateNotifier, SendState>((ref) {
  return SendStateNotifier();
});

class SendStateNotifier extends StateNotifier<SendState> {
  SendStateNotifier([SendState? state]) : super(SendState());

  void update() async {
    //Called when opening the list_page
    final now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);

    List<String> stateString = await AuthMethods().getSendState();
    if (stateString[0] != "error") {
      if (stateString[0] == "true") {
        state.statue = true;
      } else {
        state.statue = false;
      }
    }
    print(formatted);
    print(stateString[1]);
    if (stateString[1] != formatted) {
      state.statue = false;
    }
    state = state; //change the satue locally for the icon state
    AuthMethods().setSendState(state.statue); //change the satue on firebase
  }

  void change() {
    //Same but called when sending data
    AuthMethods().setSendState(true);
    state.statue = true;
    state = state;
  }
}

final B3SelectionProvider =
    StateNotifierProvider<B3SelectionNotifier, List<B3_selection>>((ref) {
  return B3SelectionNotifier();
});

class B3SelectionNotifier extends StateNotifier<List<B3_selection>> {
  B3SelectionNotifier([List<B3_selection>? state])
      : super([
          B3_selection(
              name: "Migraine",
              value: 0,
              icon: Icons.face,
              titles: ["rien", "peu", "beaucoup"]),
          B3_selection(
              name: "Mal de ventre",
              value: 0,
              icon: Icons.healing,
              titles: ["rien", "peu", "beaucoup"]),
          B3_selection(
              name: "Fatigue",
              value: 0,
              icon: Icons.healing_outlined,
              titles: ["peu", "normal", "beaucoup"]),
          B3_selection(
              name: "Eau",
              value: 0,
              icon: Icons.water,
              titles: ["peu", "moyen", "beaucoup"]),
          B3_selection(
              name: "Café",
              value: 0,
              icon: Icons.coffee,
              titles: ["peu", "moyen", "beaucoup"]),
          B3_selection(
              name: "Equilibre",
              value: 0,
              icon: Icons.food_bank,
              titles: ["peu", "moyen", "équilibré"]),
          B3_selection(
              name: "Quantité",
              value: 0,
              icon: Icons.food_bank_outlined,
              titles: ["peu", "normal", "beaucoup"]),
          B3_selection(
              name: "Cours",
              value: 0,
              icon: Icons.class_,
              titles: ["non", "oui"]),
          B3_selection(
              name: "Révision",
              value: 0,
              icon: Icons.book,
              titles: ["non", "oui"]),
          B3_selection(
              name: "Repos", value: 0, icon: Icons.bed, titles: ["non", "oui"]),
          B3_selection(
              name: "Sport",
              value: 0,
              icon: Icons.sports,
              titles: ["non", "oui"]),
        ]);

  void add(B3_selection s) async {
    state = [...state, s];
  }

  void change(value, B3_selection b3) {
    state.forEach((element) {
      if (element.name == b3.name) {
        element.value = value;
      }
    });

    state = [...state];

    b3.value = value;
  }
}

final HistoriqueProvider =
    StateNotifierProvider<HistoriqueNotifier, List<FlSpot>>((ref) {
  return HistoriqueNotifier();
});

class HistoriqueNotifier extends StateNotifier<List<FlSpot>> {
  HistoriqueNotifier([List<FlSpot>? state]) : super([]);

  void add(FlSpot s) async {
    state = [...state, s];
  }

  void removeLast() async {
    state.removeAt(0);
    state = [...state];
  }

  void load(List<FlSpot> spot) {
    state = [...spot];
  }

  void cleanList() {
    state = [];
  }
}

final DataNameProvider = StateNotifierProvider<DataNameNotifier, String>((ref) {
  return DataNameNotifier();
});

class DataNameNotifier extends StateNotifier<String> {
  DataNameNotifier([String? state]) : super("Migraine");

  void change(String newData) {
    state = newData;
  }
}
