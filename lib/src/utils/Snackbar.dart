import 'package:flutter/material.dart';

class Snackbar {
  static snackbarShow(context, String content) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        content,
      ),
      duration: const Duration(seconds: 1),
    ));
  }
}