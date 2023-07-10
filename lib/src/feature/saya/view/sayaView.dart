import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    return Column(
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
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(),
        ),
      ],
    );
  }
}
