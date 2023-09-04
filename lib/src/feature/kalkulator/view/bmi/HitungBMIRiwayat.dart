import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/utils/AppColors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../widgets/AppBarBackWidget.dart';

class HitungBMIRiwayat extends ConsumerStatefulWidget {
  const HitungBMIRiwayat({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HitungBMIRiwayatState();
}

class _HitungBMIRiwayatState extends ConsumerState<HitungBMIRiwayat> {
  GlobalKey hitungBMIRiwayatKey = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarBackWidget(),
          const SizedBox(height: 10,),
          Expanded(
            child: StreamBuilder(
              stream: dbReference.child('kalkulator_result').child(auth.currentUser!.uid).onValue,
              builder: (context, snapshot) {
                ref.read(calculatorRepositoryProvider).fetchSaveBMI(hitungBMIRiwayatKey, snapshot);
                final data = ref.read(calculatorRepositoryProvider).listSaveBMI;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${data[index].result!}',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                    ),
                                  ),
                                  const SizedBox(width: 16,),
                                  Text(
                                    data[index].keterangan!,
                                    style: GoogleFonts.poppins(
                                      color: Color(AppColors.bgGrey),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                key: Key('delete'),
                                onTap: () {
                                  ref.read(calculatorRepositoryProvider).deleteBMI(hitungBMIRiwayatKey, data[index].id!);
                                },
                                child: Icon(MdiIcons.delete),
                              ),
                            ],
                          ),
                        ),
                        const Divider(thickness: 2,)
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container();
                  },
                  itemCount: data.length
                );
              }
            ),
          )
        ],
      ),
    );
  }
}