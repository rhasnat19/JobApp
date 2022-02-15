import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UtilService {
  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[300],
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
