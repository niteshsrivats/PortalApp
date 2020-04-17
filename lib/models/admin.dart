import 'package:flutter/cupertino.dart';

import 'user.dart';

class Admin extends User {
  final String type = 'admin';

  Admin({@required uid, @required name, @required email, @required number})
      : super(uid, name, email, number);

  factory Admin.fromMap(Map<String, dynamic> data) {
    return Admin(
        uid: data['documentId'], name: data['name'], email: data['email'], number: data['number']);
  }

  @override
  String toString() {
    return 'Admin{type: $type, ${super.toString()}}';
  }
}
