import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfilWidget(
                  peringkat: 2,
                  score: 20,
                  username: 'Naufal',
                ),
                const SizedBox(
                  width: 23,
                ),
                ProfilWidget(
                  peringkat: 1,
                  score: 20,
                  username: 'Maudy',
                ),
                const SizedBox(
                  width: 23,
                ),
                ProfilWidget(
                  peringkat: 3,
                  score: 40,
                  username: 'Zain',
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Material(
                  borderRadius: const BorderRadius.all(Radius.circular(17)),
                  child: ListTile(
                    leading: Text(
                      '#$index',
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.normal),
                    ),
                    title: Text(
                      'abds',
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.normal),
                    ),
                    trailing: Text(
                      '9 Pt',
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.normal),
                    ),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(17))),
                    minLeadingWidth: 15,
                    tileColor: Colors.white,
                    isThreeLine: false,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 15,
                );
              },
              itemCount: 10,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}
