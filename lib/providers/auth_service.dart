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
    print('PROCESS TOKEN');
  }

  FirebaseUser _processAuthChange(FirebaseUser firebaseUser) {
    if (firebaseUser != null) {
      firebaseUser
          .getIdToken()
          .then(
              (result) => this._processIdTokenResult(result, firebaseUser.uid))
          .catchError((error) => print(error));
    }
    this.auth = null;
    return firebaseUser;
  }

  Stream<FirebaseUser> get onAuthStateChanged {
    return _auth.onAuthStateChanged.map(_processAuthChange);
  }

  Future<void> signInWithEmail({String email, String password}) async {
    print(this.auth);
    AuthResult authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    print(authResult.user.uid);
  }

  void signOut() {
    this.auth = null;
    _auth.signOut();
  }
}
