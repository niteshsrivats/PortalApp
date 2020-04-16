import 'package:college_main/providers/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Flutter'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text("Login"),
              onPressed: () => authService.signInWithEmail(
                  email: 'niteshsrivats.k@gmail.com', password: '123456'),
            ),
            FlatButton(
              child: Text("Logout"),
              onPressed: authService.signOut,
            )
          ],
        ),
      ),
    );
  }
}
