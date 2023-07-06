import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/AppColors.dart';

class TextFieldWidget extends HookConsumerWidget {
  String labelTitle;
  String labelField;
  bool? obfuscate;
  Function onChanged;

  TextFieldWidget({
    super.key,
    required this.labelTitle,
    required this.labelField,
    this.obfuscate = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelTitle,
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: const Color(AppColors.fontBlack),
            fontWeight: FontWeight.w500
          ),
        ),
        TextFormField(
          obscureText: obfuscate!,
          onChanged: (value) {
            onChanged(value);
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(AppColors.bgTextField),
            labelText: labelField,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(5)
                )
              )
          ),
        ),
      ],
    );
  }
}