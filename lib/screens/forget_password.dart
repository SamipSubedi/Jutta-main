import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
