import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/feature/tantangan/model/TugasModel.dart';
import 'package:healtyfy/src/feature/tantangan/view/tugas/tugasDetailView.dart';
import 'package:healtyfy/src/utils/AppColors.dart';
import 'package:healtyfy/src/widgets/CustomBigTileWidget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TugasView extends StatefulHookConsumerWidget {
  const TugasView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TugasViewState();
}

class _TugasViewState extends ConsumerState<TugasView> {
  GlobalKey tugasKey = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16,),
          Expanded(
              child: Text(
                'Daftar Tugas',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              )),
          StreamBuilder(
            stream: dbReference.child('users').child(auth.currentUser!.uid).child('id_tugas').onValue,
            builder: (context, snapshot) {
              return StreamBuilder(
                  stream: dbReference.child('list_tugas').onValue,
                  builder: (context, snapshot) {
                    ref.read(tugasRepositoryProvider).fetchDataTugas(tugasKey, snapshot);
                    ref.read(tugasRepositoryProvider).userTugas(tugasKey);
                    final fetchTugas = ref.read(tugasRepositoryProvider).listTugas;
                    final userTugasList = ref.read(tugasRepositoryProvider).userTugasList;
                    return Expanded(
                        flex: 10,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            if(userTugasList.contains(fetchTugas[index].id)){
                              return CustomBigTileWidget(
                                imagePath: fetchTugas[index].photoPath ?? '',
                                title: fetchTugas[index].titleText.toString(),
                                score: fetchTugas[index].score!.toInt(),
                                done: true,
                                tabCheck: 'tantangan',
                              );
                            }
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TugasDetailView(
                                        title: fetchTugas[index].titleText ?? '',
                                        imagePath: fetchTugas[index].photoPath ?? '',
                                        deskripsi: fetchTugas[index].deskripsi ?? '',
                                        idTugas: fetchTugas[index].id ?? '',
                                      ),
                                    )
                                );
                              },
                              child: CustomBigTileWidget(
                                imagePath: fetchTugas[index].photoPath ?? '',
                                title: fetchTugas[index].titleText.toString(),
                                score: fetchTugas[index].score!.toInt(),
                                tabCheck: 'tantangan',
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 15,
                            );
                          },
                          padding: const EdgeInsets.all(0),
                          itemCount: fetchTugas.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                        ));
                  }
              );
            }
          )
        ],
      ),
    );
  }
}
