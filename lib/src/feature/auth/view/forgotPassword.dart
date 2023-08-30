import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/feature/auth/view/widget/textFieldWidget.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';

import '../../../utils/AppColors.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  String email;

  ForgotPassword({
    super.key,
    required this.email
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  GlobalKey forgotPassKey = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          children: [
            const AppBarBackWidget(),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(27.0),
              child: TextFieldWidget(
                controller: emailController,
                keyString: 'email',
                labelTitle: 'Email',
                labelField: 'Masukkan email anda',
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
            ),
            Padding(
              padding: const EdgeInsets.all(27.0),
              child: GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    ref.read(authRepositoryProvider).forgotPass(forgotPassKey, emailController.text);
                    emailController.clear();
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
                      'Kirim',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(AppColors.fontWhite)
                      ),
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