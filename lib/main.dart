import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healtyfy/view/detail_edukasi.dart';
import 'package:healtyfy/view/dashboard.view.dart';
import 'package:healtyfy/view/detail_edukasi.dart';
import 'package:healtyfy/view/detail_obesitas.dart';
import 'package:healtyfy/view/detail_resep.dart';
import 'package:healtyfy/view/edukasi.view.dart';
import 'package:healtyfy/view/splash.view.dart';

void main(){
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardView(),
    );
  }
}