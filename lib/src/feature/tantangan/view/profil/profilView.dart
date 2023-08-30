import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/feature/tantangan/view/widgets/profilWidget.dart';
import 'package:healtyfy/src/utils/AppColors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../constants/Providers.dart';
import '../../../../widgets/CustomGridBoxWidget.dart';

class ProfilView extends StatefulHookConsumerWidget {
  const ProfilView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ProfilViewState();
}

class ProfilViewState extends ConsumerState<ProfilView> {
  GlobalKey lencanaKey = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          StreamBuilder(
              stream: dbReference
                  .child('users')
                  .child(auth.currentUser!.uid)
                  .onValue,
              builder: (context, snapshot) {
                Map<dynamic, dynamic>? data =
                    snapshot.data?.snapshot.value as Map?;
                return Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfilWidget(
                        peringkat: 1,
                        score: data?['score'] ?? 0,
                        username: data?['username'] ?? 'unknown',
                        photoPath: data?['photo'] ?? '',
                      ),
                    ],
                  ),
                );
              }),
          StreamBuilder(
              stream: dbReference.child('list_lencana').onValue,
              builder: (context, snapshot) {
                ref
                    .read(lencanaRepositoryProvider)
                    .fetchDataLencana(lencanaKey, snapshot);
                final data = ref.read(lencanaRepositoryProvider).listLencana;

                ref.read(lencanaRepositoryProvider).userLencana(lencanaKey);
                final userLencanaList =
                    ref.read(lencanaRepositoryProvider).userLencanaList;
                return Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Lencana Kamu',
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GridView.builder(
                        padding: const EdgeInsets.all(0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          if (userLencanaList.contains(data[index].id)) {
                            return CustomGridBoxWidget(
                              namaLencana: data[index].titleText,
                              imagePath: data[index].photoPath,
                            );
                          }
                          return Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13))),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Color(AppColors.bgSoftGrey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              child: Icon(
                                MdiIcons.lock,
                                color: const Color(AppColors.bgGrey),
                              ),
                            ),
                          );
                        },
                        itemCount: data.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                      )
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
