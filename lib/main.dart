import 'package:college_main/pages/login_screen.dart';
import 'package:college_main/pages/new_post_screen.dart';
import 'package:college_main/pages/newsfeed_screen.dart';
import 'package:college_main/pages/profile_screen.dart';
import 'package:college_main/providers/department_service.dart';
import 'package:college_main/providers/post_service.dart';
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
                  child = NewsfeedScreen();
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
                  ChangeNotifierProxyProvider<AuthService, DepartmentService>(
                    create: (BuildContext context) => DepartmentService(),
                    update: (BuildContext context, AuthService authService, previous) =>
                        previous..initialize(auth: authService.auth),
                    lazy: false,
                  ),
                  ChangeNotifierProxyProvider<AuthService, PostService>(
                    create: (BuildContext context) => PostService(),
                    update: (BuildContext context, AuthService authService, previous) =>
                        previous..initialize(auth: authService.auth),
                    lazy: false,
                  ),
                ],
                child: MaterialApp(
                  title: 'College Portal',
                  theme: ThemeData(
                    primarySwatch: Colors.lightBlue,
                    accentColor: Colors.lightBlue,
                    scaffoldBackgroundColor: Color(0xFFfafafa),
//                    scaffoldBackgroundColor: Color(0xFFf0f0f0),
                  ),
                  home: child,
                  routes: {
                    '/newpost': (context) => NewPostScreen(),
                    '/profile': (context) => ProfilePage(),
//                    '/': (context) => NewsfeedScreen(),
                  },
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
