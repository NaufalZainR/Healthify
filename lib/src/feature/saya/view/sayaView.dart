import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../constants/ScreenSize.dart';
import '../../../utils/AppColors.dart';
import '../../../widgets/AppBarWidget.dart';

class SayaView extends StatefulHookConsumerWidget {
  const SayaView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SayaViewState();
}

class _SayaViewState extends ConsumerState<SayaView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: ScreenSize.screenHeight(context) * 0.17,
            width: ScreenSize.screenWidth(context),
            padding: const EdgeInsets.all(15),
            decoration:
                const BoxDecoration(color: Color(AppColors.bgPrimarySoft)),
            child: SafeArea(
              child: Center(
                  child: Text(
                'Saya',
                style: GoogleFonts.poppins(
                    color: const Color(AppColors.bgWhite),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )),
            ),
          ),
          const SizedBox(
            height: 46,
          ),
          Expanded(
            child: Column(
              children: [
                Icon(
                  MdiIcons.account,
                  size: 130,
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  'Naufal',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Naufal@gmail.com',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 43,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 135,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                            color: Color(AppColors.bgPrimary),
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Text(
                          'Ubah Profile',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 22,
                    ),
                    GestureDetector(
                      child: Container(
                        width: 135,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                            color: Color(AppColors.bgPrimary),
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Text(
                          'Logout',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
