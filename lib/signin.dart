//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

late String _error;

// ignore: must_be_immutable
class SignIn extends StatelessWidget {
  //controllers for managing user credentials
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  FocusNode submitNode = FocusNode();

  //manage user signin using firebase authentication
  Future<void> signin(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // ignore: unused_local_variable

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _email.text, password: _password.text);

      print("Sign In successful");
      Navigator.of(context).pushReplacementNamed('\home');
    } on FirebaseAuthException catch (e) {
      print(e.message);
      _error = e.message!;
      Fluttertoast.showToast(
          msg: _error,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.redAccent);
    }
    //If signin successful
  }

  //Key to manage the signin form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //allows scrolling of page
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                ),
                Container(
                  width: (MediaQuery.of(context).size.width),
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email can't be empty";
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a correct email';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                        hoverColor: Theme.of(context).primaryColorLight,
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
                        hoverColor: Theme.of(context).primaryColorLight,
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
                  margin:
                      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 2),
                  //width: 200,
                  child: FlatButton(
                    focusNode: submitNode,
                    child: Text("Sign In"),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(submitNode);
                      if (_formKey.currentState!.validate()) {
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
                      }
                      signin(context);
                    },
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(25)),
                ),
                Container(
                  margin: EdgeInsets.all(2),
                  width: 160,
                  child: FlatButton(
                    child: Text(
                      "create an account",
                      style: TextStyle(color: Colors.blue),
                    ),
                    focusColor: Theme.of(context).accentColor,
                    splashColor: Theme.of(context).accentColor,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('\signup');
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
