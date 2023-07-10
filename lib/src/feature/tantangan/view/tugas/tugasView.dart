import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/utils/AppColors.dart';
import 'package:healtyfy/src/widgets/CustomBigTileWidget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TugasView extends StatefulHookConsumerWidget {
  const TugasView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TugasViewState();
}

class _TugasViewState extends ConsumerState<TugasView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Expanded(
              child: Text(
            'Daftar Tugas',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          )),
          Expanded(
              flex: 10,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return CustomBigTileWidget(
                    title: 'Apasaja',
                    score: 20,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                padding: const EdgeInsets.all(0),
                itemCount: 10,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
              ))
        ],
      ),
    );
  }
}
