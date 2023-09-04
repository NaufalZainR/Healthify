import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/feature/tantangan/view/tugas/tambahCatatanView.dart';
import 'package:healtyfy/src/utils/AppColors.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path/path.dart';

import '../../../../utils/Snackbar.dart';

class TugasCatatanView extends ConsumerStatefulWidget {
  const TugasCatatanView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => TtugasCatatanViewState();
}

class TtugasCatatanViewState extends ConsumerState<TugasCatatanView> {
  GlobalKey catatanViewKey = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

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
                  Text(
                    'Catatan',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 31,),
                  Expanded(
                    child: StreamBuilder(
                      stream: dbReference.child('catatan').child(auth.currentUser!.uid).onValue,
                      builder: (context, snapshot) {
                        ref.read(tugasRepositoryProvider).fetchCatatan(catatanViewKey, snapshot);
                        final data = ref.read(tugasRepositoryProvider).listCatatan;
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            return Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                side: BorderSide(
                                  width: 1,
                                  color: Color(AppColors.greyColor)
                                )
                              ),
                              child: ListTile(
                                title: Text(
                                  data[index].catatan!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                trailing: GestureDetector(
                                  key: Key('delete'),
                                  onTap: () {
                                    ref.read(tugasRepositoryProvider).deleteCatatan(context, data[index].id!);
                                  },
                                  child: Icon(MdiIcons.delete),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10,);
                          },
                          itemCount: data.length,
                          padding: const EdgeInsets.all(0),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('tambah'),
        backgroundColor: const Color(AppColors.bgPrimary),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TambahCatatanView()
            )
          );
        },
        child: Icon(MdiIcons.plus,),
      ),
    );
  }
}