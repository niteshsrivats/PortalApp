import 'package:college_main/providers/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// TODO forgot password
class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  SnackBar _getSnackBar(errorMessage) {
    return SnackBar(
      content: Text(errorMessage, textAlign: TextAlign.center, maxLines: 1),
      backgroundColor: Theme.of(context).primaryColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
    );
  }

  Future<void> _submit(AuthService authService) async {
    final form = _formKey.currentState;
    if (form.validate()) {
      this.setState(() => _loading = true);
      form.save();
      String errorMessage =
          await authService.signInWithEmail(email: _email, password: _password);
      if (errorMessage != null) {
        this.setState(() {
          final snackBar = _getSnackBar(errorMessage);
          _scaffoldKey.currentState.showSnackBar(snackBar);
          _loading = false;
        });
      }
    }
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email ID required';
    }
    RegExp regExp = new RegExp(r'^[\w.]*@[a-z]+\.[a-z]+(\.[a-z]+)?$');
    if (!regExp.hasMatch(value)) {
      return 'Invalid email ID';
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService =
        Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.fromLTRB(45, 45.0, 45, 0.0),
            child: Form(
              key: _formKey,
              child: _loading
                  ? Center(child: CircularProgressIndicator())
                  : ListView(
                      shrinkWrap: true,
                      children: [
                        Image(
                            image: NetworkImage(
                                'https://www.pinclipart.com/picdir/big/499-4996832_previous-wellington-college-logo-clipart.png')),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                          child: TextFormField(
                            autofocus: false,
                            maxLines: 1,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              icon: const Icon(Icons.mail_outline),
                            ),
                            validator: _validateEmail,
                            onSaved: (value) => setState(() => _email = value),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                          child: TextFormField(
                            autofocus: false,
                            obscureText: true,
                            maxLines: 1,
                            decoration: new InputDecoration(
                              labelText: 'Password',
                              icon: new Icon(Icons.lock_outline),
                            ),
                            validator: _validatePassword,
                            onSaved: (value) =>
                                setState(() => _password = value),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(40, 32, 0, 0),
                          child: SizedBox(
                            height: 40.0,
                            child: RaisedButton(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32)),
                              color: Theme.of(context).accentColor,
                              child: Text('Login',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white)),
                              onPressed: () => _submit(authService),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
