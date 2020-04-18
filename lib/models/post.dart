import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post {
  final String id;
  final String author;
  final String title;
  final String content;
  final List<String> accessSpecifiers;
  final int totalComments;
  final int totalLikes;
  final Timestamp timestamp;

  Post({
    this.id,
    @required this.author,
    @required this.title,
    @required this.content,
    @required this.accessSpecifiers,
    @required this.totalComments,
    @required this.totalLikes,
    this.timestamp,
  });

  factory Post.fromMap(Map<String, dynamic> data) {
    return new Post(
      id: data['id'],
      author: data['author'],
      title: data['title'],
      content: data['content'],
      accessSpecifiers: data['accessSpecifiers'].cast<String>(),
      totalComments: data['totalComments'],
      totalLikes: data['totalLikes'],
      timestamp: data['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> post = {
      'author': this.author,
      'title': this.title,
      'content': this.content,
      'accessSpecifiers': this.accessSpecifiers,
      'totalComments': this.totalComments,
      'totalLikes': this.totalLikes,
    };
    if (this.id != null) {
      post.putIfAbsent('id', () => this.id);
    }
    return post;
  }
}
