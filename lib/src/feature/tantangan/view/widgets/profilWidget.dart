import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../utils/AppColors.dart';

class ProfilWidget extends HookConsumerWidget {
  int peringkat;
  int score;
  String username;

  ProfilWidget({
    super.key,
    required this.peringkat,
    required this.score,
    required this.username,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$peringkat',
          style: GoogleFonts.poppins(
            color: const Color(AppColors.bgWhite),
            fontSize: 12,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 5,),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            color: Colors.black
          ),
          child: Icon(MdiIcons.account, size: peringkat == 1 ? 85 : 70, color: Colors.white,),
        ),
        const SizedBox(height: 5,),
        Text(
          '$score Pt',
          style: GoogleFonts.poppins(
            color: const Color(AppColors.bgWhite),
            fontSize: 12,
            fontWeight: FontWeight.normal
          ),
        ),
        Text(
          username,
          style: GoogleFonts.poppins(
            color: const Color(AppColors.bgWhite),
            fontSize: 10,
            fontWeight: FontWeight.normal
          ),
        ),
      ],
    );
  }
}