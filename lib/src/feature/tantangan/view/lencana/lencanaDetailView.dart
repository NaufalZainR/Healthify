import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/feature/tantangan/view/lencana/lencanaGetView.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../constants/Providers.dart';
import '../../../../utils/AppColors.dart';
import '../../../../widgets/CustomBigTileWidget.dart';
import '../../model/LencanaModel.dart';
import '../tugas/tugasDetailView.dart';

class LencanaDetailView extends StatefulHookConsumerWidget {
  LencanaModel data;

  LencanaDetailView({
    super.key,
    required this.data,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LencanaDetailViewState();
}

class _LencanaDetailViewState extends ConsumerState<LencanaDetailView> {
  GlobalKey lencanaDetailKey = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  List tugasDoneList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppBarBackWidget(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        FutureBuilder(
                          future: ref
                              .read(tugasRepositoryProvider)
                              .fetchDataImage(
                                  lencanaDetailKey, widget.data.photoPath),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: Center(
                                      child: CircularProgressIndicator()));
                            }
                            return Image.network(
                              snapshot.data!,
                              width: 80,
                              height: 80,
                            );
                          },
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.data.deskripsi,
                                maxLines: 2,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                widget.data.titleText,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Daftar Tugas',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  StreamBuilder(
                      stream: dbReference
                          .child('users')
                          .child(auth.currentUser!.uid)
                          .child('id_tugas_lencana')
                          .onValue,
                      builder: (context, snapshot) {
                        return StreamBuilder(
                            stream:
                                dbReference.child('list_tugas_lencana').onValue,
                            builder: (context, snapshot) {
                              ref
                                  .read(tugasRepositoryProvider)
                                  .fetchDataTugas(lencanaDetailKey, snapshot);
                              final fetchTugas =
                                  ref.read(tugasRepositoryProvider).listTugas;

                              ref
                                  .read(tugasRepositoryProvider)
                                  .userTugasLencana(lencanaDetailKey);
                              final userTugasList = ref
                                  .read(tugasRepositoryProvider)
                                  .userTugasListLencana;
                              return Expanded(
                                  child: ListView.separated(
                                itemBuilder: (context, index) {
                                  if (!widget.data.idListTugas
                                      .contains(fetchTugas[index].id)) {
                                    return Container();
                                  }
                                  if (userTugasList
                                      .contains(fetchTugas[index].id)) {
                                    tugasDoneList.contains(fetchTugas[index].id)
                                        ? []
                                        : tugasDoneList
                                            .add(fetchTugas[index].id);
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 15),
                                      child: CustomBigTileWidget(
                                        imagePath:
                                            fetchTugas[index].photoPath ?? '',
                                        title: fetchTugas[index]
                                            .titleText
                                            .toString(),
                                        score: fetchTugas[index].score!.toInt(),
                                        done: true,
                                        tabCheck: 'tantangan',
                                      ),
                                    );
                                  }
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TugasDetailView(
                                                title: fetchTugas[index]
                                                        .titleText ??
                                                    '',
                                                imagePath: fetchTugas[index]
                                                        .photoPath ??
                                                    '',
                                                deskripsi: fetchTugas[index]
                                                        .deskripsi ??
                                                    '',
                                                idTugas:
                                                    fetchTugas[index].id ?? '',
                                                score:
                                                    fetchTugas[index].score ??
                                                        0,
                                                check: 'lencana',
                                              ),
                                            ));
                                      },
                                      child: CustomBigTileWidget(
                                        imagePath:
                                            fetchTugas[index].photoPath ?? '',
                                        title: fetchTugas[index]
                                            .titleText
                                            .toString(),
                                        score: fetchTugas[index].score!.toInt(),
                                        tabCheck: 'tantangan',
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 0,
                                  );
                                },
                                padding: const EdgeInsets.all(0),
                                itemCount: fetchTugas.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                              ));
                            });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: GestureDetector(
                      onTap: () {
                        if (tugasDoneList.length !=
                            widget.data.idListTugas.length) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Error'),
                                content:
                                    const Text('Semua tugas belum dikerjakan!'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Oke"))
                                ],
                              );
                            },
                          );
                          return;
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LencanaGetView(data: widget.data),
                            ));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 36),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
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
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
