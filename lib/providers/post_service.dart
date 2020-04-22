import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_main/models/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostService with ChangeNotifier {
  final Firestore _db = Firestore.instance;
  final FirebaseUser _user;
  Map<dynamic, dynamic> _claims;
  List<Post> posts = [];

  PostService(this._user) {
    init();
  }

  void init() async {
    _claims = await _user.getIdToken().then((result) => result.claims).catchError((error) {
      print(error);
      return null;
    });
  }

  void post({Map<String, dynamic> data}) async {
    var result = await _db.collection('posts').add(data);
    print(result);
  }

  void getPosts(List<String> accessSpecifiers) async {
    List<DocumentSnapshot> documents = await _db
        .collection('posts')
        .where('accessSpecifiers', arrayContainsAny: accessSpecifiers)
        .orderBy('createdAt', descending: true)
        .getDocuments()
        .then((docs) => docs.documents);

    int previousLength = posts.length;
    posts = documents.map((doc) => Post.fromMap(doc.data)).toList();
    if (previousLength != 0 || posts.length != 0) {
      notifyListeners();
    }
  }
}
