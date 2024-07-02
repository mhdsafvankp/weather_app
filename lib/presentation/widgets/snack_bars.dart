

import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String msg) {
   var errorSnackBar = SnackBar(
    content: Text(msg),
    backgroundColor: Colors.red,
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(5),
  );
  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
}