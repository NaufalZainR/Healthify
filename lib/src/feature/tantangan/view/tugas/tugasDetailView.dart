import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../constants/ScreenSize.dart';
import '../../../../utils/AppColors.dart';
import '../../../../widgets/CustomBigTileWidget.dart';

class TugasDetailView extends ConsumerStatefulWidget {
  String imageUrl;
  String title;
  String deskripsi;

  TugasDetailView({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.deskripsi,
  });

  @override
  ConsumerState createState() => _TugasDetailViewState();
}

class _TugasDetailViewState extends ConsumerState<TugasDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarBackWidget(),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32,),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        color: Color(AppColors.bgPrimary)
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.network(widget.imageUrl)
                          ),
                          const SizedBox(width: 25,),
                          Text(
                            widget.title,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text(
                      widget.deskripsi,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                    SizedBox(height: ScreenSize.screenHeight(context) * 0.4,),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 36),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              color: Color(AppColors.bgPrimary)
                          ),
                          child: Text(
                            'Selesai',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}
