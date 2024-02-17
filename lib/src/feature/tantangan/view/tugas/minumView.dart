import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healtyfy/src/feature/tantangan/view/tugas/minumView/minumLacakView.dart';
import 'package:healtyfy/src/feature/tantangan/view/tugas/minumView/minumRiwayatView.dart';
import 'package:healtyfy/src/feature/tantangan/view/tugas/minumView/minumWadahView.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../utils/AppColors.dart';

class MinumView extends ConsumerStatefulWidget {
  const MinumView(this.index, {super.key});

  final int index;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MinumViewState();
}

class MinumViewState extends ConsumerState<MinumView> {

  List<Widget> pages = [
    const MinumWadahView(),
    const MinumLacakView(),
    const MinumRiwayatView(),
  ];

  var indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(widget.index),
    );
  }
}