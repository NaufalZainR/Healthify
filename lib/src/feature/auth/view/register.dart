import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/AppColors.dart';
import 'widget/textFieldWidget.dart';

class Register extends StatefulHookConsumerWidget {
  const Register({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  GlobalKey registerKey = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey();

  String? usernameController;
  String? emailController;
  String? passwordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: registerKey,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(27.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Daftar',
                style: GoogleFonts.poppins(
                    fontSize: 27,
                    color: const Color(AppColors.fontBlack),
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 23,
              ),
              TextFieldWidget(
                labelTitle: 'Username',
                labelField: 'Masukkan username anda',
                onChanged: (val) {
                  setState(() {
                    usernameController = val;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFieldWidget(
                labelTitle: 'Email',
                labelField: 'Masukkan email anda',
                onChanged: (val) {
                  setState(() {
                    emailController = val;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFieldWidget(
                labelTitle: 'Password',
                labelField: 'Masukkan password anda',
                obfuscate: true,
                onChanged: (val) {
                  setState(() {
                    passwordController = val;
                  });
                },
              ),
              const SizedBox(
                height: 41,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 54,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                      color: Color(AppColors.bgPrimary),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Text(
                      'Daftar',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(AppColors.fontWhite)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah punya akun?',
                    style: GoogleFonts.poppins(
                        color: const Color(AppColors.fontBlack),
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                          color: const Color(AppColors.fontGreen),
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
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
