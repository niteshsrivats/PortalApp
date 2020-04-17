import 'package:college_main/pages/login_screen.dart';
import 'package:college_main/pages/newsfeed_screen.dart';
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
                ],
                child: MaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    primarySwatch: MaterialColor(
                      0xFF4fc3f7,
                      const <int, Color>{
                        50: const Color(0xFFdcdce8),
                        100: const Color(0xFFcbcad8),
                        200: const Color(0xFFbab9cc),
                        300: const Color(0xFFa9a8bf),
                        400: const Color(0xFF53517f),
                        500: const Color(0xFF4fc3f7),
                        600: const Color(0xFF312f54),
                        700: const Color(0xFF24233f),
                        800: const Color(0xFF1e1e35),
                        900: const Color(0xFF06060b),
                      },
                    ),
//                    primaryColor: Colors.white,
                    accentColor: Colors.orange,
                    scaffoldBackgroundColor: Color(0xFFfafafa),
//                    scaffoldBackgroundColor: Color(0xFFf0f0f0),
                  ),
                  home: child,
                  routes: {
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
