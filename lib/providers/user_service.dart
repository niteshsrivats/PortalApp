import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_main/models/admin.dart';
import 'package:college_main/models/auth.dart';
import 'package:college_main/models/student.dart';
import 'package:college_main/models/teacher.dart';
import 'package:college_main/models/user.dart';
import 'package:flutter/material.dart';

class UserService with ChangeNotifier {
  final Firestore _db = Firestore.instance;
  Auth _auth;
  User user;

  UserService();

  void initialize({@required Auth auth}) async {
    if (auth == null) {
      return null;
    }
    if (_auth == null) {
      _auth = auth;
      String collection = _auth.role == 'admin' ? 'admins' : 'users';
      user = await _db
          .collection(collection)
          .document(_auth.uid)
          .get()
          .then((snapshot) => _getUserFromDocument(snapshot.data))
          .catchError((error) => print(error));
      print(user);
    }
  }

  User getUser() {
    return user;
  }

  User _getUserFromDocument(Map<String, dynamic> data) {
    if (_auth.role == 'admin') {
      return new Admin.fromMap(data);
    } else if (_auth.role == 'teacher') {
      return new Teacher.fromMap(data);
    } else if (_auth.role == 'student') {
      return new Student.fromMap(data);
    }
    return null;
  }
}
