import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weaver/validate.dart';

// ignore: unused_import
import 'signin.dart';

class SignUp extends StatelessWidget {
  // Controllers for managing user signup
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _username = new TextEditingController();

  //Key for managing signup form
  final submitKey = GlobalKey<FormState>();

  late String errormsg;

  //Manage user sign up with firebase authentication
  Future<void> signup(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      Navigator.of(context).pushReplacementNamed('\signin');
    } on FirebaseAuthException catch (e) {
      errormsg = e.message!;
      Fluttertoast.showToast(
          msg: errormsg,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.redAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.all(30),
          child: Form(
            key: submitKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 30,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                ),
                Container(
                  width: (MediaQuery.of(context).size.width),
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name can't be empty";
                      }
                      if (value.length < 2) {
                        return "Name must be at least 2 characters long";
                      }
                      if (value.length > 50) {
                        return "Name must be less than 50 characters long";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "Enter Username:",
                        hintText: "Username",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25))),
                    controller: _username,
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width) ,
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email can't be empty";
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a correct email';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: "Enter Your Email:",
                        hintText: "Your Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25))),
                    controller: _email,
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width),
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password can't be empty";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Enter Password:",
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25))),
                    controller: _password,
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width) / 2,
                  margin: EdgeInsets.all(10),
                  child: FlatButton(
                    child: Text("Sign Up"),
                    onPressed: () {
                      if (submitKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Processing Data'),
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ]),
                          backgroundColor: Theme.of(context).primaryColorLight,
                          duration: Duration(seconds: 1),
                        ));
                        // Timer(Duration(seconds: 2), () {
                        //   Navigator.of(context).pushReplacementNamed('\home');
                        // });
                      }

                      signup(context);
                    },
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(25)),
                ),
                Container(
                  margin: EdgeInsets.all(2),
                  width: 100,
                  child: FlatButton(
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.blue),
                    ),
                    focusColor: Theme.of(context).accentColor,
                    splashColor: Theme.of(context).accentColor,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('\signin');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
