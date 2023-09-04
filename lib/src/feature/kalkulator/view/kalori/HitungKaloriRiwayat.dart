import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HitungKaloriRiwayat extends ConsumerStatefulWidget {
  const HitungKaloriRiwayat({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HitungKaloriRiwayatState();
}

class _HitungKaloriRiwayatState extends ConsumerState<HitungKaloriRiwayat> {
  GlobalKey hitungKaloriRiwayatKey = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppBarBackWidget(),
          const SizedBox(height: 10,),
          Expanded(
            child: StreamBuilder(
              stream: dbReference.child('kalori_result').child(auth.currentUser!.uid).onValue,
              builder: (context, snapshot) {
                ref.read(calculatorRepositoryProvider).fetchKalori(context, snapshot);
                final data = ref.read(calculatorRepositoryProvider).listSaveKalori;
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
                                    '${data[index].result!} KKAL',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                    ),
                                  ),
                                  const SizedBox(width: 16,),
                                ],
                              ),
                              GestureDetector(
                                key: Key('delete'),
                                onTap: () {
                                  ref.read(calculatorRepositoryProvider).deleteKalori(context, data[index].id!);
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
              },
            ),
          )
        ],
      ),
    );
  }
}