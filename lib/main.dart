import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healtyfy/src/feature/auth/view/login.dart';
import 'package:healtyfy/src/healtyfy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Healtyfy',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Healtyfy(),
    );
  }
}

class Checker extends HookConsumerWidget {
  const Checker({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
