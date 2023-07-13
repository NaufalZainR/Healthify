import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../constants/ScreenSize.dart';
import '../utils/AppColors.dart';

class AppBarBackWidget extends ConsumerWidget {
  const AppBarBackWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: ScreenSize.screenHeight(context) * 0.17,
      width: ScreenSize.screenWidth(context),
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(color: Color(AppColors.bgPrimarySoft)),
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: Icon(MdiIcons.arrowLeft),
            ),
          ),
        ),
      ),
    );
  }
}
