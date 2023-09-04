import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MinumRiwayatView extends ConsumerStatefulWidget {
  const MinumRiwayatView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MinumRiwayatViewState();
}

class _MinumRiwayatViewState extends ConsumerState<MinumRiwayatView> {
  GlobalKey minumRiwayatKey = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  String tempDate = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppBarBackWidget(),
        Expanded(
          child: StreamBuilder(
            stream: dbReference.child('users').child(auth.currentUser!.uid).child('minum').onValue,
            builder: (context, snapshot) {
              ref.read(tugasRepositoryProvider).fetchMinum(context, snapshot);
              final data = ref.read(tugasRepositoryProvider).listMinum;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              return ListView.separated(
                itemBuilder: (context, index) {
                  if (tempDate != data[index].time) {
                    tempDate = data[index].time ?? '';
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            data[index].time ?? '',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${data[index].minumMl!} ml',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                key: Key('delete'),
                                onTap: () {
                                  ref.read(tugasRepositoryProvider).hapusMinum(context, data[index].id!);
                                },
                                child: Icon(MdiIcons.delete),
                              ),
                            ],
                          ),
                        ),
                        const Divider(thickness: 2,)
                      ],
                    );
                  }
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
                                  '${data[index].minumMl!} ml',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                ref.read(tugasRepositoryProvider).hapusMinum(context, data[index].id!);
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
                itemCount: data.length,
                padding: const EdgeInsets.all(0),
              );
            },
          )
        )
      ],
    );
  }
}