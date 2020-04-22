import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_main/models/post.dart';
import 'package:flutter/material.dart';

class PostService with ChangeNotifier {
  final Firestore _db = Firestore.instance;
  List<Post> posts = [];

  PostService();

  void post({Map<String, dynamic> data}) {
    _db.collection('posts').add(data);
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
