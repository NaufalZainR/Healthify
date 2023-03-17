import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healtyfy/view/utils/constant.dart';
import 'package:healtyfy/view/login.view.dart';
import 'package:healtyfy/view/utils/global.colors.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.to(const LoginView());
    });
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/logo.png"),
          ),
          const Center(
              child: Text(
            'Healtyfy',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          )),
        ],
      ),
    );
  }
}
