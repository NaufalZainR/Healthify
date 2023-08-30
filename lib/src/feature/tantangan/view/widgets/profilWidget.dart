import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../constants/Providers.dart';
import '../../../../utils/AppColors.dart';

class ProfilWidget extends HookConsumerWidget {
  int peringkat;
  int score;
  String username;
  String photoPath;
  int photoSize;

  ProfilWidget({
    super.key,
    required this.peringkat,
    required this.score,
    required this.username,
    this.photoPath = '',
    this.photoSize = 70
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalKey profilWidgetKey = GlobalKey();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$peringkat',
          style: GoogleFonts.poppins(
            color: const Color(AppColors.bgWhite),
            fontSize: 15,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 5,),
        photoPath == '' ? Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            color: Colors.black
          ),
          child: Icon(MdiIcons.account, size: peringkat == 1 ? 117 : photoSize != 70 ? 117 : 70, color: Colors.white,),
        ) : FutureBuilder(
            future: ref.read(authRepositoryProvider).fetchUserImage(profilWidgetKey, photoPath),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(child: CircularProgressIndicator())
                );
              }
              return SizedBox(
                width: peringkat == 1 ? 117 : photoSize != 70 ? 117 : 70,
                height: peringkat == 1 ? 117 : photoSize != 70 ? 117 : 70,
                child: CircleAvatar(backgroundImage: Image.network(snapshot.data!).image));
            },
          ),
        const SizedBox(height: 5,),
        Text(
          username,
          style: GoogleFonts.poppins(
            color: const Color(AppColors.bgWhite),
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),
        ),
        Text(
          '$score Pt',
          style: GoogleFonts.poppins(
            color: const Color(AppColors.bgWhite),
            fontSize: 12,
            fontWeight: FontWeight.w400
          ),
        ),
      ],
    );
  }
}