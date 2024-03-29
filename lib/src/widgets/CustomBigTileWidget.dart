import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/ScreenSize.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/Providers.dart';
import '../utils/AppColors.dart';

class CustomBigTileWidget extends StatefulHookConsumerWidget {
  String imagePath;
  String title;
  String subTitle;
  String tabCheck;
  int score;
  String namaKategori;
  bool done;

  CustomBigTileWidget({
    required this.imagePath,
    super.key,
    required this.title,
    this.subTitle = '',
    required this.tabCheck,
    this.score = -1,
    this.namaKategori = '',
    this.done = false,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomBigTileWidgetState();
}

class _CustomBigTileWidgetState extends ConsumerState<CustomBigTileWidget> {
  GlobalKey bigTileKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: const Color(AppColors.bgSoftGrey)),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: Color(widget.done ? AppColors.bgSoftGrey : AppColors.bgWhite),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            height: 76,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.tabCheck == 'tantangan')...[
                  FutureBuilder(
                    future: ref.read(tugasRepositoryProvider).fetchDataImage(bigTileKey, widget.imagePath),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const SizedBox(
                            width: 50,
                            height: 50,
                            child: Center(child: CircularProgressIndicator())
                        );
                      }
                      return Image.network(snapshot.data!) ;
                    },
                  ),
                  const SizedBox(width: 15,),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 38),
                      child: Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                ] else if(widget.tabCheck == 'resep')...[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: ScreenSize.screenWidth(context) * 0.2),
                          child: Text(
                            widget.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Text(
                          widget.subTitle,
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            color: Color(AppColors.bgGrey)
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else...[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 38),
                      child: Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(AppColors.bgPrimary),
                borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomLeft: Radius.circular(12))
              ),
              child: Text(
                widget.tabCheck == 'edukasi' || widget.tabCheck == 'resep' ? widget.namaKategori : '${widget.score} Pt',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}