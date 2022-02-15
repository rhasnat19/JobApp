// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

Future<void> showLoadingAnimation(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (context) {
      return Center(child: CircularProgressIndicator());
    },
  );
}

Future<void> showAlertTextBox(BuildContext context, String text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        backgroundColor: Colors.black,
        content: Container(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    },
  );
}
