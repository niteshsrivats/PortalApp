import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_main/models/auth.dart';
import 'package:flutter/material.dart';

class DepartmentService with ChangeNotifier {
  final Firestore _db = Firestore.instance;
  Auth _auth;
  List<String> departments;

  DepartmentService();

  void initialize({@required Auth auth}) async {
    if (auth == null) {
      return null;
    }
    if (auth.role == 'admin' && _auth == null) {
      _auth = auth;
      const String collection = 'departments';
      departments = await _db
          .collection(collection)
          .document(collection)
          .get()
          .then((snapshot) => (snapshot.data['codes'].cast<String>()))
          .catchError((error) => print(error));
      print(departments);
    }
  }

  List<String> getDepartments() {
    return departments;
  }
}
