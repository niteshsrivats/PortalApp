import 'package:college_main/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_service.dart';
import 'providers/user_service.dart';

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
            builder:
                (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
//              Widget child;
//              if (snapshot.connectionState == ConnectionState.active) {
//                if(snapshot.data == null) {
//                  child = Login
//                } else {
//                  child = Home
//                }
//              } else {
//                child = Loader - May not be required, we'll take a call in the end
//              }
              return MultiProvider(
                providers: [
                  ChangeNotifierProxyProvider<AuthService, UserService>(
                    create: (BuildContext context) =>
                        UserService(auth: _authService.auth),
//                        lazy: false,
                    update: (BuildContext context, AuthService authService,
                            previous) =>
                        previous..update(authService.auth),
                  ),
                ],
                child: MaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: Scaffold(
                    body: Center(
                      child: Test(),
//                      child: CircularProgressIndicator(),
                    ),
                  ),
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
