import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("assets/images/logo.png"))),
                  padding: EdgeInsets.only(
                    top: 24.0,
                  ),
                  child: Text(
                    "ForgetPassword",
                    textAlign: TextAlign.center,
                    style: Constants.boldHeading,
                  ),
                ),
                Container(
                    child: Form(
                  key: _formkey,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter your email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Email Here',
                      contentPadding: EdgeInsets.all(
                        50.0,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                )),
                RaisedButton(
                  child: Text(
                    'Reset Password',
                  ),
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      dynamic result = await resetPassword(email);
                      if (result == null) {
                        setState(() {
                          Fluttertoast.showToast(msg: "Enter valid email");
                          return;
                        });
                      }
                    }
                  },
                  padding: EdgeInsets.all(10),
                )
              ]),
        ),
      ),
    );
  }
}
