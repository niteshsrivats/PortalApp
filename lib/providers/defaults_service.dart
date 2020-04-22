import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DefaultsService with ChangeNotifier {
  final Firestore _db = Firestore.instance;

  final FirebaseUser _user;
  List<String> departments;
  List<String> semesters;
  List<String> years;

  DefaultsService(this._user) {
    _init();
  }

  void _init() async {
    Map<dynamic, dynamic> claims =
        await _user.getIdToken().then((result) => result.claims).catchError((error) {
      print(error);
      return null;
    });

    if (claims.containsKey('admin')) {
      Map<String, dynamic> data = await _db
          .collection('defaults')
          .document('default')
          .get()
          .then((snapshot) => (snapshot.data))
          .catchError((error) => print(error));

      departments = data['codes'].cast<String>();
      semesters = data['semesters'].cast<String>();
      years = data['years'].cast<String>();
      notifyListeners();
    }
  }
}
