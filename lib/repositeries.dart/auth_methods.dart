import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:app22/model/B3_selection.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Signing Up User

  // Future<String> saveData2({required List<B3_selection> list}) async {
  //   User? user = _auth.currentUser;

  //   List<String> selectionsNames =
  //       list.map((selec) => selec.name).toList(growable: false);
  //   List<String> selectionsValues =
  //       list.map((selec) => selec.value.toString()).toList(growable: false);

  //   if (user != null) {
  //     final now = DateTime.now();
  //     final DateFormat formatter = DateFormat('yyyy-MM-dd');
  //     final String formatted = formatter.format(now);

  //     await _firestore
  //         .collection("users")
  //         .doc(user.uid)
  //         .collection("data")
  //         .doc("{$formatted}")
  //         .set({"list": selectionsValues});

  //     return "success";
  //   } else {
  //     return " error";
  //   }
  // }

  // Future<String> saveData({required List<B3_selection> list}) async {
  //   User? user = _auth.currentUser;

  //   List<String> selectionsNames =
  //       list.map((selec) => selec.name).toList(growable: false);
  //   List<String> selectionsValues =
  //       list.map((selec) => selec.value.toString()).toList(growable: false);

  //   if (user != null) {
  //     final now = DateTime.now();
  //     final DateFormat formatter = DateFormat('yyyy-MM-dd');
  //     final String formatted = formatter.format(now);

  //     for (B3_selection i in list) {
  //       await _firestore
  //           .collection("users")
  //           .doc(user.uid)
  //           .collection("data")
  //           .doc("{$formatted}")
  //           .update({i.name: i.value});
  //     }

  //     return "success";
  //   } else {
  //     return " error";
  //   }
  // }

  Future<String> saveAddData({required List<B3_selection> list}) async {
    User? user = _auth.currentUser;

    List<String> selectionsNames =
        list.map((selec) => selec.name).toList(growable: false);
    List<String> selectionsValues =
        list.map((selec) => selec.value.toString()).toList(growable: false);

    if (user != null) {
      final now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(now);
      Map<String, Object?> mapList = {};

      for (B3_selection i in list) {
        mapList.addAll({i.name: i.value});
      }
      mapList.addAll({"date": formatted});
      await _firestore
          .collection("users")
          .doc(user.uid)
          .collection("data")
          .add(mapList);

      return "success";
    } else {
      return "error";
    }
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty != null) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // adding user in our database
        await _firestore.collection("users").doc(cred.user!.uid).set({
          'pseudo': username,
          'uid': cred.user!.uid,
          'email': email,
          'sendState': false,
        });

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<List<String>> getSendState() async {
    User? user = _auth.currentUser;
    if (user != null) {
      var userSnap = await _firestore.collection('users').doc(user.uid).get();
      bool state = userSnap.data()!['sendState'];
      String date = userSnap.data()!['date'];

      return [state.toString(), date];
    }
    return ["Error"];
  }

  Future<void> setSendState(bool state) async {
    final now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'pseudo': user.displayName,
        'uid': user.uid,
        'email': user.email,
        'sendState': state,
        'date': formatted,
      });
    }
  }

  // Future<List<String>> getData() async {
  //   try {
  //     User? user = _auth.currentUser;
  //     if (user != null) {
  //       var userSnap = await _firestore
  //           .collection('users')
  //           .doc(user.uid)
  //           .collection("data")
  //           .doc("date")
  //           .get();
  //       var dataList = userSnap.data()!['date'];

  //       return dataList;
  //     }
  //     return ["null"];
  //   } catch (e) {
  //     print(e.toString());
  //     return ["null"];
  //   }
  // }
}
