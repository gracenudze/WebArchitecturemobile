import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Logout extends StatefulWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  _Logout createState() => _Logout();
}

class _Logout extends State<Logout> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  signOut(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Signing Out'),
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ]),
      backgroundColor: Theme.of(context).primaryColorLight,
      duration: Duration(seconds: 2),
    ));
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('\signup');
    });
    return _firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            width: 250,
            height: 250,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(25)),
            child: FlatButton(
              child: Text(
                "Signout",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              focusColor: Theme.of(context).accentColor,
              splashColor: Theme.of(context).accentColor,
              onPressed: () {
                signOut(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
