import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/feature/auth/view/login.dart';
import 'package:healtyfy/src/feature/auth/view/register.dart';
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
      home: const Checker(),
    );
  }
}

class Checker extends HookConsumerWidget {
  const Checker({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authCheck = ref.watch(authCheckerProvider);

    return authCheck.when(
      data: (data) {
        if (data == null) return const Login();
        return Healtyfy();
      },
      error: (error, stackTrace) {
        return Container();
      },
      loading: () {
        return Container();
      },
    );
  }
}
