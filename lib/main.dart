import 'package:college_main/pages/login.dart';
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
            builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
              Widget child;
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data == null) {
                  child = LoginScreen();
                } else {
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
                    create: (BuildContext context) => UserService(auth: _authService.auth),
//                        lazy: false,
                    update: (BuildContext context, AuthService authService, previous) =>
                        previous..update(authService.auth),
                  ),
                ],
                child: MaterialApp(
                    title: 'Flutter Demo',
                    theme: ThemeData(
                      primarySwatch: MaterialColor(0xFFff9800, const <int, Color>{
                        50: const Color(0xFFfff3e0),
                        100: const Color(0xFFffe0b2),
                        200: const Color(0xFFffcc80),
                        300: const Color(0xFFffb74d),
                        400: const Color(0xFFffa726),
                        500: const Color(0xFFff9800),
                        600: const Color(0xFFfb8c00),
                        700: const Color(0xFFf57c00),
                        800: const Color(0xFFef6c00),
                        900: const Color(0xFFe65100),
                      }),
                      primaryColor: Color(0xFFff9800),
                      accentColor: Color(0xFF4fc3f7),
                    ),
                    home: child),
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
