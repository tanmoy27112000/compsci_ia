import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Email'),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Log In'),
                  onPressed: () async {
                    try {
                      await auth
                          .signInWithEmailAndPassword(
                              email: _email, password: _password)
                          .catchError(() {
                        toast("Invalid user");
                      });
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } catch (e) {
                      toast(e.toString());
                    }
                  }),
              RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Sign Up'),
                  onPressed: () async {
                    final auth = FirebaseAuth.instance;
                    try {
                      await auth.createUserWithEmailAndPassword(
                          email: _email, password: _password);
                      auth.currentUser.sendEmailVerification();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } catch (e) {
                      print(e);
                      toast(e.toString());
                    }
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
