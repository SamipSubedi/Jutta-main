import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExceptionHandler extends StatefulWidget {
  @override
  _ExceptionHandlerState createState() => _ExceptionHandlerState();
}

class _ExceptionHandlerState extends State<ExceptionHandler> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<void> _alertDialogBuilder(context, String error) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Container(
            child: Text(error),
          ),
          actions: [
            FlatButton(
              child: Text("Close Dialog"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}
