import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/feature/auth/view/widget/textFieldWidget.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';

import '../../../utils/AppColors.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  GlobalKey forgotPassKey = GlobalKey();

  String? emailController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            const AppBarBackWidget(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(27.0),
              child: TextFieldWidget(
                  labelTitle: 'Email',
                  labelField: 'Masukkan email anda',
                  onChanged: (val) {
                    setState(() {
                      emailController = val;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(27.0),
              child: GestureDetector(
                onTap: () {
                  ref
                      .read(authRepositoryProvider)
                      .forgotPass(forgotPassKey, emailController.toString());
                },
                child: Container(
                  height: 54,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                      color: Color(AppColors.bgPrimary),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Text(
                      'Kirim',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(AppColors.fontWhite)),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
