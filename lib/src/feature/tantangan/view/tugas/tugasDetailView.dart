import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../constants/ScreenSize.dart';
import '../../../../utils/AppColors.dart';
import '../../../../widgets/CustomBigTileWidget.dart';

class TugasDetailView extends ConsumerStatefulWidget {
  String imagePath;
  String title;
  String deskripsi;
  String idTugas;
  int score;
  String check;

  TugasDetailView(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.deskripsi,
      required this.idTugas,
      required this.score,
      this.check = 'tugas'});

  @override
  ConsumerState createState() => _TugasDetailViewState();
}

class _TugasDetailViewState extends ConsumerState<TugasDetailView> {
  GlobalKey tugasDetailKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarBackWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(22)),
                          color: Color(AppColors.bgPrimary)),
                      child: Row(
                        children: [
                          FutureBuilder(
                              future: ref
                                  .read(tugasRepositoryProvider)
                                  .fetchDataImage(
                                      tugasDetailKey, widget.imagePath),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Center(
                                          child: CircularProgressIndicator()));
                                }
                                return SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: Image.network(snapshot.data!));
                              }),
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            widget.title,
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.deskripsi,
                      style: GoogleFonts.poppins(
                          fontSize: 13, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: ScreenSize.screenHeight(context) * 0.4,
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: GestureDetector(
                        onTap: () {
                          widget.check == 'tugas'
                              ? ref.read(tugasRepositoryProvider).tugasSelesai(
                                  tugasDetailKey, widget.idTugas, widget.score)
                              : ref
                                  .read(tugasRepositoryProvider)
                                  .tugasLencanaSelesai(tugasDetailKey,
                                      widget.idTugas, widget.score);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 36),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              color: Color(AppColors.bgPrimary)),
                          child: Text(
                            'Selesai',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
