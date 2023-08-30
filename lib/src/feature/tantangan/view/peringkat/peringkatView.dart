import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/feature/tantangan/view/widgets/profilWidget.dart';
import 'package:healtyfy/src/utils/AppColors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PeringkatView extends StatefulHookConsumerWidget {
  const PeringkatView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => PeringkatViewState();
}
class PeringkatViewState extends ConsumerState<PeringkatView> {
  GlobalKey peringkatKey = GlobalKey();
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: StreamBuilder(
        stream: dbReference.child('users').onValue,
        builder: (context, snapshot) {
          ref.read(tugasRepositoryProvider).fetchUserRank(peringkatKey, snapshot);
          final data = ref.read(tugasRepositoryProvider).listRank;
          final dataFilter = ref.read(tugasRepositoryProvider).listRankFilter;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
                width: 60,
                height: 60,
                child: Center(child: CircularProgressIndicator())
            );
          }
          return Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfilWidget(
                      peringkat: 2,
                      score: data[1].score,
                      username: data[1].username,
                      photoPath: data[1].photoPath,
                    ),
                    const SizedBox(width: 23,),
                    ProfilWidget(
                      peringkat: 1,
                      score: data[0].score,
                      username: data[0].username,
                      photoPath: data[0].photoPath,
                    ),
                    const SizedBox(width: 23,),
                    ProfilWidget(
                      peringkat: 3,
                      score: data[2].score,
                      username: data[2].username,
                      photoPath: data[2].photoPath,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Material(
                      borderRadius: const BorderRadius.all(Radius.circular(17)),
                      child: ListTile(
                        leading: Text(
                          '#${index+4}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.normal
                          ),
                        ),
                        title: Text(
                          dataFilter[index].username,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.normal
                          ),
                        ),
                        trailing: Text(
                          '${dataFilter[index].score} Pt',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.normal
                          ),
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(17))
                        ),
                        minLeadingWidth: 15,
                        tileColor: Colors.white,
                        isThreeLine: false,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 15,);
                  },
                  itemCount: dataFilter.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}