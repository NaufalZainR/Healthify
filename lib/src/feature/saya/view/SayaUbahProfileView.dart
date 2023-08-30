import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/constants/ScreenSize.dart';
import 'package:healtyfy/src/feature/auth/view/widget/textFieldWidget.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../utils/AppColors.dart';
import '../../../utils/Snackbar.dart';

class SayaUbahProfileView extends ConsumerStatefulWidget {

  const SayaUbahProfileView({super.key,});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SayaUbahProfileViewState();
}

class _SayaUbahProfileViewState extends ConsumerState<SayaUbahProfileView> {
  GlobalKey sayaKey = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(children: [
          const AppBarBackWidget(),
          const SizedBox(height: 46,),
          GestureDetector(
            key: Key('changePhoto'),
            onTap: () {
              ref.read(sayaRepositoryProvider).uploadPhoto(sayaKey);
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(48),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Colors.black
              ),
              child: Icon(MdiIcons.cameraOutline, size: 36, color: Colors.white,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFieldWidget(
              controller: usernameController,
              keyString: 'username',
              labelTitle: 'Username',
              labelField: 'masukkan username baru',
              validatorCallback: (val){
                if (val.isEmpty) {
                  return 'Username tidak boleh kosong!';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 43,),
          GestureDetector(
            onTap: () {
              if (formKey.currentState!.validate()) {
                ref.read(sayaRepositoryProvider).changeUsername(sayaKey, usernameController.text);
                Snackbar.snackbarShow(context, 'Berhasil dirubah!');
                FocusScope.of(context).unfocus();
                Navigator.of(context).pop();
              }
            },
            child: Container(
              height: 37,
              width: ScreenSize.screenWidth(context) * 0.35,
              decoration: const BoxDecoration(
                color: Color(AppColors.bgPrimary),
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Center(
                child: Text(
                  'Ubah',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(AppColors.fontWhite)
                  ),
                ),
              ),
            ),
          ),
        ],),
      ),
    );
  }
}