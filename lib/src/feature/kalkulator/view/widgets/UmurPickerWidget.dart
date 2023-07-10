import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../constants/ScreenSize.dart';
import '../../../../utils/AppColors.dart';

class UmurPickerWidget extends ConsumerStatefulWidget {
  Function onChanged;

  UmurPickerWidget({
    super.key,
    required this.onChanged
  });

  @override
  ConsumerState createState() => _UmurPickerWidgetState();
}

class _UmurPickerWidgetState extends ConsumerState<UmurPickerWidget> {
  var umurValue = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 17,
              color: Colors.black.withOpacity(0.25)
          )
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
                color: const Color(AppColors.bgGrey)
            ),
          ),
          const SizedBox(height: 11,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (umurValue <= 1)return;
                    umurValue--;
                    widget.onChanged(umurValue);
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Color(AppColors.bgPrimary)
                  ),
                  child: Icon(MdiIcons.minus, color: Colors.white,),
                ),
              ),
              const SizedBox(width: 25,),
              Text(
                  '${umurValue.toInt()}',
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  )
              ),
              const SizedBox(width: 25,),
              GestureDetector(
                onTap: () {
                  setState(() {
                    umurValue++;
                    widget.onChanged(umurValue);
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Color(AppColors.bgPrimary)
                  ),
                  child: Icon(MdiIcons.plus, color: Colors.white,),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
