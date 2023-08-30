import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/ScreenSize.dart';
import 'package:healtyfy/src/feature/resep/model/ResepModel.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';

import '../../../constants/Providers.dart';

class ResepDetailView extends ConsumerWidget {
  ResepModel data;

  ResepDetailView({
    super.key,
    required this.data
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalKey resepDetailKey = GlobalKey();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBarBackWidget(),
            Stack(
              children: [
                data.photoPath != '' ? FutureBuilder(
                  future: ref.read(tugasRepositoryProvider).fetchDataImage(resepDetailKey, data.photoPath),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const SizedBox(
                          width: 50,
                          height: 50,
                          child: Center(child: CircularProgressIndicator())
                      );
                    }
                    return SizedBox(
                      width: ScreenSize.screenWidth(context),
                      child: Image.network(snapshot.data!)) ;
                  },
                ) : Container(),
                Container(
                  margin: EdgeInsets.only(top: data.photoPath != '' ? ScreenSize.screenHeight(context) * 0.25 : 0),
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data.title} (${data.subtitle})',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 22,),
                      Text(
                        'Resep',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 22,),
                      Text(
                        data.resepText.split('\\').join('\n'),
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                      const SizedBox(height: 22,),
                      Text(
                        'Cara membuat',
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 22,),
                      Text(
                        data.tutorialText.split('\\').join('\n'),
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ],
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
