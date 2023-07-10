import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/feature/tantangan/view/widgets/profilWidget.dart';
import 'package:healtyfy/src/utils/AppColors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfilView extends StatefulHookConsumerWidget {
  const ProfilView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ProfilViewState();
}

class ProfilViewState extends ConsumerState<ProfilView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfilWidget(peringkat: 1, score: 30, username: 'Maudy'),
              ],
            ),
          ),
          Expanded(
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(13))),
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
                  itemCount: 3,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
