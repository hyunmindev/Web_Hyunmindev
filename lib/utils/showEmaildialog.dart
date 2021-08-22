import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> showEmailDialog(context, email) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('My email'),
        content: Text(email),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffb68b7e),
            ),
            child: Text('copy'),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: email));
            },
          ),
          OutlinedButton(
            child: Text('cancel'),
            style: OutlinedButton.styleFrom(
              primary: Color(0xffb68b7e),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
