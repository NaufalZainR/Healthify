import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/constants/ScreenSize.dart';

import '../utils/AppColors.dart';

class CustomGridBoxWidget extends ConsumerStatefulWidget {
  String namaLencana;
  String imagePath;
  bool done;

  CustomGridBoxWidget(
      {super.key,
      required this.namaLencana,
      required this.imagePath,
      this.done = false});

  @override
  ConsumerState createState() => _CustomGridBoxWidgetState();
}

class _CustomGridBoxWidgetState extends ConsumerState<CustomGridBoxWidget> {
  GlobalKey customGridKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.done ? const Color(AppColors.bgSoftGrey) : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        border: Border.all(width: 2, color: const Color(AppColors.bgSoftGrey)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: ref
                .read(lencanaRepositoryProvider)
                .fetchDataImage(customGridKey, widget.imagePath),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                    width: ScreenSize.screenWidth(context) * 0.05,
                    height: ScreenSize.screenHeight(context) * 0.05,
                    child: Center(child: CircularProgressIndicator()));
              }
              return Image.network(
                snapshot.data!,
                height: ScreenSize.screenHeight(context) * 0.05,
              );
            },
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            widget.namaLencana,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
                fontSize: 10, fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}
