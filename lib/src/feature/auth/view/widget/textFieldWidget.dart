import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/AppColors.dart';

class TextFieldWidget extends ConsumerStatefulWidget {
  TextEditingController controller;
  String keyString;
  String labelTitle;
  String labelField;
  bool? obfuscate;
  Function validatorCallback;

  TextFieldWidget({
    super.key,
    required this.controller,
    this.keyString = '',
    required this.labelTitle,
    required this.labelField,
    this.obfuscate = false,
    required this.validatorCallback,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends ConsumerState<TextFieldWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelTitle,
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: const Color(AppColors.fontBlack),
            fontWeight: FontWeight.w500
          ),
        ),
        TextFormField(
          controller: widget.controller,
          key: Key(widget.keyString),
          obscureText: widget.obfuscate!,
          validator: (value) {
            return widget.validatorCallback(value);
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(AppColors.bgTextField),
            labelText: widget.labelField,
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