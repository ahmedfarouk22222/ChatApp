import 'package:chatapp/constant.dart';
import 'package:flutter/material.dart';

void snackbarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        message,
        style: TextStyle(color: primaryColor),
      ),
    ),
  );
}
