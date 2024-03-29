import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../utils/AppColors.dart';

class UmurPickerWidget extends ConsumerStatefulWidget {
  Function onChanged;
  int value;

  UmurPickerWidget({super.key, required this.onChanged, required this.value});

  @override
  ConsumerState createState() => _UmurPickerWidgetState();
}

class _UmurPickerWidgetState extends ConsumerState<UmurPickerWidget> {
  TextEditingController umurController = TextEditingController();

  var editText = false;

  @override
  Widget build(BuildContext context) {
    var umurValue = widget.value;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 17, color: Colors.black.withOpacity(0.25))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Umur',
            style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: const Color(AppColors.bgGrey)),
          ),
          const SizedBox(
            height: 11,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                key: Key('umurMin'),
                onTap: () {
                  setState(() {
                    if (umurValue <= 1) return;
                    umurValue--;
                    widget.onChanged(umurValue);
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Color(AppColors.bgPrimary)),
                  child: Icon(
                    MdiIcons.minus,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              editText
                  ? SizedBox(
                      width: 30,
                      child: EditableText(
                        controller: umurController,
                        focusNode: FocusNode(),
                        autofocus: true,
                        style: GoogleFonts.poppins(
                            fontSize: 20, color: Colors.black),
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        backgroundCursorColor: Colors.black,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onSubmitted: (value) {
                          setState(() {
                            if (value.isNotEmpty) {
                              widget.onChanged(int.parse(value));
                            }
                            editText = false;
                          });
                        },
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          editText = true;
                        });
                      },
                      child: Text('${umurValue.toInt()}',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                    ),
              const SizedBox(
                width: 25,
              ),
              GestureDetector(
                key: Key('umurPlus'),
                onTap: () {
                  setState(() {
                    umurValue++;
                    widget.onChanged(umurValue);
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Color(AppColors.bgPrimary)),
                  child: Icon(
                    MdiIcons.plus,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
