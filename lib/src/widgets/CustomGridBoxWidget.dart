import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../feature/tantangan/model/LencanaModel.dart';
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.done ? const Color(AppColors.bgSoftGrey) : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        border: Border.all(width: 2, color: const Color(AppColors.bgSoftGrey)),
      ),
      child: Column(
        children: [
          FutureBuilder(
            future: ref
                .read(lencanaRepositoryProvider)
                .fetchDataImage(customGridKey, widget.imagePath),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(child: CircularProgressIndicator()));
              }
              return Image.network(snapshot.data!);
            },
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
