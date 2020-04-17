import 'package:college_main/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_service.dart';
import 'providers/user_service.dart';
import 'test.dart';

void main() {
  runApp(new App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthService>(
      create: (BuildContext context) => AuthService(),
      child: Builder(
        builder: (BuildContext context) {
          final _authService = Provider.of<AuthService>(context, listen: false);
          return StreamBuilder<FirebaseUser>(
            stream: _authService.onAuthStateChanged,
            builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
              Widget child;
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data == null) {
                  child = LoginScreen();
                } else {
//                  child = LoginScreen();
                  child = Test();
                }
              } else {
                child = Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              return MultiProvider(
                providers: [
                  ChangeNotifierProxyProvider<AuthService, UserService>(
                    create: (BuildContext context) => UserService(),
                    update: (BuildContext context, AuthService authService, previous) =>
                        previous..initialize(auth: authService.auth),
                    lazy: false,
                  ),
                ],
                child: MaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    primarySwatch: Colors.orange,
                    primaryColor: Colors.orange,
                    accentColor: Color(0xFF4fc3f7),
                  ),
                  home: child,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

//  Widget build(BuildContext context) {
//    return MultiProvider(providers: [
//      StreamProvider<FirebaseUser>.value(
//          value: FirebaseAuth.instance.onAuthStateChanged)
//    ], child:
//    ););

//    return new MaterialApp(
//        title: 'College Information Portal',
//        debugShowCheckedModeBanner: false,
//        theme: new ThemeData(
//          primarySwatch: Colors.blue,
//        ),
//        home: new RootPage(auth: new Auth()));
