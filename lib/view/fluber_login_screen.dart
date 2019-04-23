import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/presenter/navigation.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FluberLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _LoginEmailEditText _loginEmailEditText = _LoginEmailEditText();
    _LoginPasswordEditText _loginPasswordEditText = _LoginPasswordEditText();

    return ScopedModelDescendant<UserModel>(
        builder: (context, child, user) => Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: user.newUser
                          ? AssetImage("images/ABBAS_KHORSHIDI.jpg")
                          : AssetImage("images/girl.png"),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.grey, BlendMode.multiply)),
                ),
                child: ListView(children: <Widget>[
                  _TitleSection(),
                  _loginEmailEditText,
                  _loginPasswordEditText,
                  _LoginButton(),
                  _RegisterButton()
                ]),
              ),
            ));
  }
}


class _TitleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 120.0, 24.0, 24.0),
      child: Center(
        child: Text(
          ScopedModel.of<UserModel>(context).newUser
              ? 'Join the flowers lovers family'
              : 'Discover florists that deliver near you',
          style: TextStyle(
            fontSize: 36.0,
            color: Color(0xfffcfcfc),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _LoginEmailEditText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 8.0, 24.0, 0.0),
      child: TextField(
        controller: TextEditingController(
            text: ScopedModel.of<UserModel>(context).userEmail),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Email',
        ),
        onChanged: (String email) {
          ScopedModel.of<UserModel>(context).userEmail = email;
        },
      ),
    );
  }
}

class _LoginPasswordEditText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 8.0, 24.0, 8.0),
      child: TextField(
        controller: new TextEditingController(
            text: ScopedModel.of<UserModel>(context).userPassword),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Password',
        ),
        onChanged: (String password) {
          ScopedModel.of<UserModel>(context).userPassword = password;
        },
        obscureText: true,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 8.0, 24.0, 0.0),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: () {
          ScopedModel.of<UserModel>(context).newUser
              ? _signedIn(context)
              : _loggedIn(context);
        },
        child: Text(
            ScopedModel.of<UserModel>(context).newUser ? 'Sign in' : 'Login'),
      ),
    );
  }

  void _signedIn(BuildContext context) {
    _handleSignIn(ScopedModel.of<UserModel>(context).userEmail,
            ScopedModel.of<UserModel>(context).userPassword)
        .then((FirebaseUser user) {
      print("Signed in " + user.toString());
      ScopedModel.of<UserModel>(context).firebaseUser = user;
      Navigation.goToFlowersScreen(context);
    }).catchError((e) => print(e.toString() + e.runtimeType.toString()));
  }

  void _loggedIn(BuildContext context) {
    _handleLogin(ScopedModel.of<UserModel>(context).userEmail,
            ScopedModel.of<UserModel>(context).userPassword)
        .then((FirebaseUser user) {
      print("Login " + user.toString());
      ScopedModel.of<UserModel>(context).firebaseUser = user;
      Navigation.goToFlowersScreen(context);
    }).catchError((e) => print(e.toString() + e.runtimeType.toString()));
  }

  Future<FirebaseUser> _handleSignIn(String email, String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user;
  }

  Future<FirebaseUser> _handleLogin(String email, String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user;
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 8.0),
      child: Container(
        alignment: AlignmentDirectional.topEnd,
        child: FlatButton(
          textColor: Colors.white,
          onPressed: () {
            ScopedModel.of<UserModel>(context).newUser =
                !ScopedModel.of<UserModel>(context).newUser;
          },
          child: Text(ScopedModel.of<UserModel>(context).newUser
              ? 'Have an account?'
              : 'Don’t have an account?'),
        ),
      ),
    );
  }
}
