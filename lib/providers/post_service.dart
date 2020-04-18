import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_main/models/auth.dart';
import 'package:college_main/models/post.dart';
import 'package:flutter/material.dart';

class PostService with ChangeNotifier {
  final Firestore _db = Firestore.instance;
  Auth _auth;
  List<Post> posts = [];

  PostService();

  void initialize({@required Auth auth}) async {
    if (auth != null && _auth == null) {
      _auth = auth;
    }
  }

  void post() async {
    Map<String, dynamic> post = new Post(
      author: 'Nitesh Srivats',
      title: '6A CSE',
      content:
          'Lorem ipsum dolor sit amet, consectetur adipisi adipisicing elit. Asperiores aut dignissimos dolorem dolorum ducimus fuga in, numquam odio pariatur possimus quasi sint sunt ut? Placeat.',
      accessSpecifiers: [],
      totalComments: 78,
      totalLikes: 223,
    ).toMap();
    var result = await _db.collection('posts').add(post);
    print(result);
  }

  void getPosts() async {
    List<DocumentSnapshot> documents =
        await _db.collection('posts').getDocuments().then((docs) => docs.documents);

    posts = documents.map((doc) => Post.fromMap(doc.data)).toList();
  }
}
