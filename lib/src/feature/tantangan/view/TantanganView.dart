import 'package:flutter/material.dart';
import 'package:healtyfy/src/feature/tantangan/view/lencana/lencanaView.dart';
import 'package:healtyfy/src/feature/tantangan/view/peringkat/peringkatView.dart';
import 'package:healtyfy/src/feature/tantangan/view/profil/profilView.dart';
import 'package:healtyfy/src/feature/tantangan/view/tugas/tugasView.dart';
import 'package:healtyfy/src/widgets/AppBarWidget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TantanganView extends StatefulHookConsumerWidget {
  const TantanganView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TantanganViewState();
}
class _TantanganViewState extends ConsumerState<TantanganView> {
  List<String> tabItem = [
    'Peringkat',
    'Profil',
    'Tugas',
    'Lencana'
  ];

  List<Widget> viewItem = [
    const PeringkatView(),
    const ProfilView(),
    const TugasView(),
    const LencanaView(),
  ];

  var selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarWidget(
          tabItem: tabItem,
          selectedCallback: (value){
            setState(() {
              selectedTab = value;
            });
          }
        ),
        Expanded(
          child: viewItem[selectedTab],
        ),
      ],
    );
  }
}