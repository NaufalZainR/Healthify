import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              )),
          Expanded(
              flex: 10,
              child: GridView.builder(
                padding: const EdgeInsets.all(0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LencanaDetailView(),
                          )
                      );
                    },
                    child: CustomGridBoxWidget(
                        namaLencana: 'Testing'
                    ),
                  );
                },
                itemCount: 3,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
              )
          )
        ],
      ),
    );
  }
}