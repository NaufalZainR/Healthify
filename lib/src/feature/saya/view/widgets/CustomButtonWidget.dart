import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/AppColors.dart';

class CustomButtonWidget extends ConsumerStatefulWidget {
  Function onTap;
  String teks;
  String result;

  CustomButtonWidget({
    super.key,
    required this.onTap,
    required this.teks,
    required this.result,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends ConsumerState<CustomButtonWidget> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
        decoration: const BoxDecoration(
            color: Color(AppColors.bgPrimary),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.teks,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),
            ),
            Row(
              children: [
                Text(
                  widget.result,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),
                ),
                const SizedBox(width: 12,),
                Text(
                  '>',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}