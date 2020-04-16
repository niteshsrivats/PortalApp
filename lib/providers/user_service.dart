import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_main/models/auth.dart';
import 'package:college_main/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserService with ChangeNotifier {
  final Firestore _db = Firestore.instance;
  Auth auth;
  User user;

  UserService({@required this.auth});

  void update(Auth auth) {
    print("LOL");
    print(auth);
  }

//  String _role;

//  Future<User> _userFromFirebase(FirebaseUser firebaseUser) async {
//    if (firebaseUser == null) {
//      return null;
//    }
//    final lol = await firebaseUser.getIdToken();
//    print(lol);
//    return Admin(
//      number: "lol",
//      name: "lol",
//      email: "lol",
//      uid: "lol",
//    );
//  }

}
