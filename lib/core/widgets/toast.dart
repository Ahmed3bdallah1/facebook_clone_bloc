// Show Toast Message
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastMessage({
  required String text,
}) {
  Fluttertoast.showToast(
    msg: text,
    backgroundColor: Colors.black54,
    fontSize: 18,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
  );
}