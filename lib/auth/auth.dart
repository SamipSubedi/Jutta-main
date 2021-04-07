import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoesfyp2/widgets/exceptionHandler.dart';

// Create a new user account
class AccountLogin extends StatefulWidget {
  @override
  _AccountLoginState createState() => _AccountLoginState();
}

class _AccountLoginState extends State<AccountLogin> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<String> _loginAccount(_loginEmail, _loginPassword) async {
    ExceptionHandler();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}
