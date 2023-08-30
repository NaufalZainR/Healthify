import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MinumWadahView extends ConsumerStatefulWidget {
  const MinumWadahView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MinumWadahViewState();
}

class _MinumWadahViewState extends ConsumerState<MinumWadahView> {
  List minumMl = [
    100,
    200,
    300,
    400,
    600,
    1000,
  ];

  List iconMinum = [
    MdiIcons.coffee,
    MdiIcons.cupOutline,
    MdiIcons.cup,
    MdiIcons.beerOutline,
    MdiIcons.beer,
    MdiIcons.glassMug,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppBarBackWidget(),
        const SizedBox(
          height: 46,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'Wadah',
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 64,
              ),
              GridView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: minumMl.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      ref
                          .read(tugasRepositoryProvider)
                          .tambahMinum(context, minumMl[index]);
                    },
                    child: Column(
                      children: [
                        Icon(
                          iconMinum[index],
                          size: 60,
                        ),
                        Text(
                          '${minumMl[index]}',
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
