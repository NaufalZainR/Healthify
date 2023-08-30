import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/feature/tantangan/view/lencana/lencanaDetailView.dart';
import 'package:healtyfy/src/widgets/CustomGridBoxWidget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../utils/AppColors.dart';
import '../../../../widgets/CustomBigTileWidget.dart';

class LencanaView extends StatefulHookConsumerWidget {
  const LencanaView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LencanaViewState();
}
class _LencanaViewState extends ConsumerState<LencanaView> {
  GlobalKey lencanaKey = GlobalKey();
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
                'Daftar Lencana',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              )),
          StreamBuilder(
            stream: dbReference.child('users').child(auth.currentUser!.uid).child('id_lencana').onValue,
            builder: (context, snapshot) {
              return StreamBuilder(
                stream: dbReference.child('list_lencana').onValue,
                builder: (context, snapshot) {
                  ref.read(lencanaRepositoryProvider).fetchDataLencana(lencanaKey, snapshot);
                  final data = ref.read(lencanaRepositoryProvider).listLencana;

                  ref.read(lencanaRepositoryProvider).userLencana(lencanaKey);
                  final userLencanaList = ref.read(lencanaRepositoryProvider).userLencanaList;
                  return Expanded(
                      flex: 10,
                      child: GridView.builder(
                        padding: const EdgeInsets.all(0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10
                        ),
                        itemBuilder: (context, index) {
                          if (userLencanaList.contains(data[index].id)) {
                            return CustomGridBoxWidget(
                                namaLencana: data[index].titleText,
                                imagePath: data[index].photoPath,
                                done: true,
                            );
                          }
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LencanaDetailView(data: data[index]),
                                  )
                              );
                            },
                            child: CustomGridBoxWidget(
                                namaLencana: data[index].titleText,
                                imagePath: data[index].photoPath,
                            ),
                          );
                        },
                        itemCount: data.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                      )
                  );
                }
              );
            }
          )
        ],
      ),
    );
  }
}