import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../utils/AppColors.dart';

class CustomGridBoxWidget extends ConsumerStatefulWidget {
  String namaLencana;

  CustomGridBoxWidget({super.key, required this.namaLencana});

  @override
  ConsumerState createState() => _CustomGridBoxWidgetState();
}

class _CustomGridBoxWidgetState extends ConsumerState<CustomGridBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        border: Border.all(width: 2, color: const Color(AppColors.bgSoftGrey)),
      ),
      child: Column(
        children: [
          Icon(
            MdiIcons.account,
            size: 60,
          ),
          Text(
            widget.namaLencana,
            style: GoogleFonts.poppins(
                fontSize: 11, fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}
