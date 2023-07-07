import 'package:flutter/material.dart';

class ScreenSize {
  static screenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static screenHeight(context) {
    return MediaQuery.of(context).size.height;
  }
}
