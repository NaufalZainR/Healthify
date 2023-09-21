import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/ScreenSize.dart';
import 'package:healtyfy/src/utils/AppColors.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';

import '../../../../constants/Providers.dart';
import '../../model/LencanaModel.dart';

class LencanaGetView extends ConsumerWidget {
  LencanaModel data;

  LencanaGetView({
    super.key,
    required this.data
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalKey lencanaGetKey = GlobalKey();
    return Scaffold(
      backgroundColor: const Color(AppColors.bgPrimary),
      body: Column(
        children: [
          const AppBarBackWidget(),
          SizedBox(height: ScreenSize.screenHeight(context) * 0.15,),
          Container(
            padding: const EdgeInsets.all(21),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(13))
            ),
            child: Column(
              children: [
                FutureBuilder(
                  future: ref.read(tugasRepositoryProvider).fetchDataImage(lencanaGetKey, data.photoPath),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const SizedBox(
                          width: 80,
                          height: 80,
                          child: Center(child: CircularProgressIndicator())
                      );
                    }
                    return Image.network(snapshot.data!, height: 130, width: 130,) ;
                  },
                ),
                Text(
                  data.titleText,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  'Selamat anda telah menjadi anti junkfood',
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(AppColors.greyColor)
                  ),
                ),
                const SizedBox(height: 15,),
                GestureDetector(
                  onTap: () {
                    ref.read(lencanaRepositoryProvider).getLencana(lencanaGetKey, data.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 36),
                    decoration: const BoxDecoration(
                      color: Color(AppColors.bgPrimary),
                      borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                    child: Text(
                      'Ambil Lencana',
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
