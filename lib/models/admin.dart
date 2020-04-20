import 'package:flutter/cupertino.dart';

import 'user.dart';

class Admin extends User {
  final String title;

  Admin(
      {@required uid,
      @required name,
      @required email,
      @required number,
      @required image,
      @required this.title})
      : super(uid, name, email, number, 'admin', image);

  factory Admin.fromMap(Map<String, dynamic> data) {
    return Admin(
      uid: data['documentId'],
      image: data['image'],
      name: data['name'],
      email: data['email'],
      number: data['number'],
      title: data['title'],
    );
  }

  @override
  String toString() {
    return 'Admin{title: $title, ${super.toString()}}';
  }
}
