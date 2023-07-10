import 'package:flutter/material.dart';
import 'package:healtyfy/src/feature/kalkulator/view/bmi/HitungBMI.dart';
import 'package:healtyfy/src/feature/kalkulator/view/kalori/HitungKalori.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widgets/AppBarWidget.dart';

class KalkulatorView extends StatefulHookConsumerWidget {
  const KalkulatorView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KalkulatorViewState();
}

class _KalkulatorViewState extends ConsumerState<KalkulatorView> {
  List<String> tabItem = [
    'Hitung BMI',
    'Hitung Kalori Harian',
  ];

  List<Widget> viewItem = [const HitungBMI(), const HitungKalori()];

  var selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarWidget(
            tabItem: tabItem,
            selectedCallback: (value) {
              setState(() {
                selectedTab = value;
              });
            }),
        Expanded(
          child: viewItem[selectedTab],
        ),
      ],
    );
  }
}
