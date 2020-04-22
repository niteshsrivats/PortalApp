import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post {
  final String id;
  final String author;
  final String authorId;
  final String authorEmail;
  final String image;
  final String title;
  final String content;
  final List<String> accessSpecifiers;
  final Timestamp timestamp;

  Post({
    this.id,
    @required this.author,
    @required this.authorId,
    @required this.authorEmail,
    @required this.image,
    @required this.title,
    @required this.content,
    @required this.accessSpecifiers,
    this.timestamp,
  });

  factory Post.fromMap(Map<String, dynamic> data) {
    return new Post(
      id: data['id'],
      author: data['author'],
      authorId: data['authorId'],
      authorEmail: data['authorEmail'],
      image: data['image'],
      title: data['title'],
      content: data['content'],
      accessSpecifiers: data['accessSpecifiers'].cast<String>(),
      timestamp: data['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> post = {
      'author': this.author,
      'authorId': this.authorId,
      'authorEmail': this.authorEmail,
      'image': this.image,
      'title': this.title,
      'content': this.content,
      'accessSpecifiers': this.accessSpecifiers,
    };
    if (this.id != null) {
      post.putIfAbsent('id', () => this.id);
    }
    return post;
  }

  @override
  String toString() {
    return 'Post{id: $id, author: $author, authorId: $authorId, authorEmail: $authorEmail, image: $image, title: $title, content: $content, accessSpecifiers: $accessSpecifiers, timestamp: $timestamp}';
  }
}
