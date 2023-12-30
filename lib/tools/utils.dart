import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String type, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: type == "error" ? Colors.red : Colors.black,
      content: Text(message),
      duration: const Duration(seconds: 1),
    ),
  );
}
