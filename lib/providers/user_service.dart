import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_main/models/admin.dart';
import 'package:college_main/models/student.dart';
import 'package:college_main/models/teacher.dart';
import 'package:college_main/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserService with ChangeNotifier {
  final Firestore _db = Firestore.instance;
  final FirebaseUser _user;
  Map<dynamic, dynamic> _claims;
  User user;

  UserService(this._user) {
    init();
  }

  void init() async {
    _claims = await _user.getIdToken().then((result) => result.claims).catchError((error) {
      print(error);
      return null;
    });

    String collection = _claims.containsKey('admin') ? 'admins' : 'users';
    user = await _db
        .collection(collection)
        .document(_user.uid)
        .get()
        .then((snapshot) => _getUserFromDocument(snapshot.data))
        .catchError((error) => print(error));
    notifyListeners();
  }

  void setImage(String url) {
    String collection = _claims.containsKey('admin') ? 'admins' : 'users';
    user.image = url;
    _db.collection(collection).document(user.uid).updateData({'image': url});
    _db.collection('posts').where('authorId', isEqualTo: user.uid).getDocuments().then((snap) {
      snap.documents.forEach((document) {
        _db.collection('posts').document(document.data['id'].toString()).updateData({'image': url});
      });
    });
    notifyListeners();
  }

  User _getUserFromDocument(Map<String, dynamic> data) {
    if (_claims.containsKey('admin')) {
      return new Admin.fromMap(data);
    } else if (_claims.containsKey('teacher')) {
      return new Teacher.fromMap(data);
    } else if (_claims.containsKey('student')) {
      return new Student.fromMap(data);
    }
    return null;
  }
}
