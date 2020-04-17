import 'package:college_main/models/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Auth auth;

  void _processIdTokenResult(IdTokenResult idTokenResult, uid) {
    String role;
    if (idTokenResult.claims.containsKey('admin')) {
      role = 'admin';
    } else if (idTokenResult.claims.containsKey('teacher')) {
      role = 'teacher';
    } else if (idTokenResult.claims.containsKey('student')) {
      role = 'student';
    }
    this.auth = new Auth(uid: uid, token: idTokenResult.token, role: role);
  }

  FirebaseUser _processAuthChange(FirebaseUser firebaseUser) {
    if (firebaseUser != null) {
      firebaseUser
          .getIdToken()
          .then((result) => this._processIdTokenResult(result, firebaseUser.uid))
          .catchError((error) => print(error));
    }
    this.auth = null;
    return firebaseUser;
  }

  Stream<FirebaseUser> get onAuthStateChanged {
    return _auth.onAuthStateChanged.map(_processAuthChange);
  }

  Future<String> signInWithEmail({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          return "Your email address appears to be malformed";
        case "ERROR_WRONG_PASSWORD":
          return "Your password is wrong";
        case "ERROR_USER_NOT_FOUND":
          return "User with this email doesn't exist";
        case "ERROR_USER_DISABLED":
          return "User with this email has been disabled";
        case "ERROR_TOO_MANY_REQUESTS":
          return "Too many requests. Try again later";
        case "ERROR_OPERATION_NOT_ALLOWED":
          return "Signing in with Email and Password is not enabled";
        default:
          return "An undefined Error happened";
      }
    }
  }

  void signOut() {
    this.auth = null;
    _auth.signOut();
  }
}
