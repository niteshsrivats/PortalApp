import 'package:college_main/pages/login_screen.dart';
import 'package:college_main/pages/new_post_screen.dart';
import 'package:college_main/pages/newsfeed_screen.dart';
import 'package:college_main/pages/profile_screen.dart';
import 'package:college_main/providers/defaults_service.dart';
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
  final Key homeKey = UniqueKey();
  final Key loadingKey = UniqueKey();

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
              print(snapshot);

              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data == null) {
                  return MaterialAppWithRoutes(routes: {'/': (context) => LoginScreen()});
                } else {
                  return Home(
                    key: homeKey,
                    user: snapshot.data,
                    routes: {
                      '/': (context) => NewsfeedScreen(),
                      '/post': (context) => NewPostScreen(),
                      '/profile': (context) => ProfilePage(),
                    },
                  );
                }
              } else {
                return MaterialAppWithRoutes(
                  key: loadingKey,
                  routes: {
                    '/': (context) => Scaffold(body: Center(child: CircularProgressIndicator()))
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  final Map<String, Widget Function(BuildContext)> routes;
  final FirebaseUser user;

  const Home({Key key, this.user, this.routes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<UserService>(
        create: (BuildContext context) => UserService(user),
        lazy: false,
      ),
      ChangeNotifierProvider<DefaultsService>(
        create: (BuildContext context) => DefaultsService(user),
        lazy: false,
      ),
      ChangeNotifierProvider<PostService>(
        create: (BuildContext context) => PostService(user),
        lazy: false,
      ),
    ], child: MaterialAppWithRoutes(routes: routes));
  }
}

class MaterialAppWithRoutes extends StatelessWidget {
  final Map<String, Widget Function(BuildContext)> routes;

  const MaterialAppWithRoutes({Key key, this.routes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'College Portal',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        accentColor: Colors.lightBlue,
        scaffoldBackgroundColor: Color(0xFFfafafa),
//                    scaffoldBackgroundColor: Color(0xFFf0f0f0),
      ),
      routes: routes,
    );
  }
}
