import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/constants/ScreenSize.dart';
import 'package:healtyfy/src/feature/auth/view/login.dart';
import 'package:healtyfy/src/healtyfy.dart';
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

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: registerKey,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(27.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: ScreenSize.screenHeight(context) * 0.2,),
                Text(
                  'Daftar',
                  style: GoogleFonts.poppins(
                    fontSize: 27,
                    color: const Color(AppColors.fontBlack),
                    fontWeight: FontWeight.w600
                  ),
                ),
                const SizedBox(height: 23,),
                TextFieldWidget(
                  controller: usernameController,
                  keyString: 'username',
                  labelTitle: 'Username',
                  labelField: 'Masukkan username anda',
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(12)
                  ],
                  validatorCallback: (val){
                    if (val.isEmpty) {
                      return 'Username tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15,),
                TextFieldWidget(
                  controller: emailController,
                  keyString: 'email',
                  labelTitle: 'Email',
                  labelField: 'Masukkan email anda',
                  inputFormatters: [],
                  validatorCallback: (val){
                    if (val.isEmpty) {
                      return 'Email tidak boleh kosong!';
                    }
                    if (!val.contains('@')) {
                      return 'Masukkan email dengan benar!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15,),
                TextFieldWidget(
                  controller: passwordController,
                  keyString: 'password',
                  labelTitle: 'Password',
                  labelField: 'Masukkan password anda',
                  obfuscate: true,
                  inputFormatters: [],
                  validatorCallback: (val){
                    if (val.isEmpty) {
                      return 'Password tidak boleh kosong!';
                    }
                    if (val.length < 6) {
                      return 'Kata sandi minimal 6 huruf!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 41,),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      ref.read(authRepositoryProvider).signUpWithEmailAndPassword(
                          context,
                          emailController.text,
                          passwordController.text,
                          usernameController.text
                      );
                      usernameController.clear();
                      emailController.clear();
                      passwordController.clear();
                    }
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
                        'Daftar',
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
                      'Sudah punya akun?',
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
                          MaterialPageRoute(builder: (context) => const Login()),
                        );
                      },
                      child: Text(
                        'Login',
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
      ),
    );
  }
}