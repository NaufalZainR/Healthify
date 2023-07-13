import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/ScreenSize.dart';
import 'package:healtyfy/src/utils/AppColors.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LencanaGetView extends ConsumerWidget {
  const LencanaGetView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(AppColors.bgPrimary),
      body: Column(
        children: [
          const AppBarBackWidget(),
          SizedBox(
            height: ScreenSize.screenHeight(context) * 0.15,
          ),
          Container(
            padding: const EdgeInsets.all(21),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(13))),
            child: Column(
              children: [
                Icon(
                  MdiIcons.account,
                  size: 130,
                ),
                Text(
                  'Anti Junk food',
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Selamat anda telah menjadi anti junkfood',
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(AppColors.greyColor)),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 36),
                    decoration: const BoxDecoration(
                        color: Color(AppColors.bgPrimary),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Text(
                      'Ambil Lencana',
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
