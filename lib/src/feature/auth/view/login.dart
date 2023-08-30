import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/feature/auth/view/forgotPassword.dart';
import 'package:healtyfy/src/feature/auth/view/register.dart';
import 'package:healtyfy/src/feature/auth/view/widget/textFieldWidget.dart';
import 'package:healtyfy/src/utils/AppColors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Login extends StatefulHookConsumerWidget {
  const Login({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  GlobalKey loginKey = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey();

  String? emailController;
  String? passwordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: loginKey,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(27.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Masuk',
                style: GoogleFonts.poppins(
                  fontSize: 27,
                  color: const Color(AppColors.fontBlack),
                  fontWeight: FontWeight.w600
                ),
              ),
              const SizedBox(height: 23,),
              TextFieldWidget(
                labelTitle: 'Email',
                labelField: 'Masukkan email anda',
                onChanged: (val){
                  setState(() {
                    emailController = val;
                  });
                },
              ),
              const SizedBox(height: 15,),
              TextFieldWidget(
                labelTitle: 'Password',
                labelField: 'Masukkan password anda',
                obfuscate: true,
                onChanged: (val){
                  setState(() {
                    passwordController = val;
                  });
                },
              ),
              const SizedBox(height: 22,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ForgotPassword()),
                      );
                    },
                    child: Text(
                      'Lupa Password?',
                      style: GoogleFonts.poppins(
                        color: Color(AppColors.fontRed),
                        fontSize: 13,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 22,),
              GestureDetector(
                onTap: () {
                  ref.read(authRepositoryProvider).signInWithEmailAndPassword(
                      loginKey,
                      emailController.toString(),
                      passwordController.toString()
                  );
                },
                child: Container(
                  height: 54,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    color: Color(AppColors.bgPrimary),
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Center(
                    child: Text(
                      'Masuk',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(AppColors.fontWhite)
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Kamu belum punya akun?',
                    style: GoogleFonts.poppins(
                      color: const Color(AppColors.fontBlack),
                      fontSize: 13,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(width: 2,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Register()),
                      );
                    },
                    child: Text(
                      'Daftar',
                      style: GoogleFonts.poppins(
                        color: const Color(AppColors.fontGreen),
                        fontSize: 13,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}