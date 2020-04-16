import 'package:flutter/cupertino.dart';

class Auth {
  final String uid;
  final String token;
  final String role;

  Auth({@required this.uid, @required this.token, @required this.role});

  @override
  String toString() {
    return 'Auth{uid: $uid, token: $token, role: $role}';
  }
}
