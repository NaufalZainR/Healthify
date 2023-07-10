import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../utils/AppColors.dart';

class CustomBigTileWidget extends StatefulHookConsumerWidget {
  String title;
  int score;

  CustomBigTileWidget({super.key, required this.title, required this.score});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomBigTileWidgetState();
}

class _CustomBigTileWidgetState extends ConsumerState<CustomBigTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border.all(width: 2, color: const Color(AppColors.bgSoftGrey)),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  MdiIcons.account,
                  size: 50,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Positioned(
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Color(AppColors.bgPrimary),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(3))),
                child: Text(
                  '${widget.score} Pt',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              )),
        ],
      ),
    );
  }
}
