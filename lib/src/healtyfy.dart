import 'package:flutter/material.dart';
import 'package:healtyfy/src/feature/edukasi/view/EdukasiView.dart';
import 'package:healtyfy/src/feature/kalkulator/view/KalkulatorView.dart';
import 'package:healtyfy/src/feature/resep/view/ResepView.dart';
import 'package:healtyfy/src/feature/saya/view/SayaView.dart';
import 'package:healtyfy/src/feature/tantangan/view/TantanganView.dart';
import 'package:healtyfy/src/utils/AppColors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Healtyfy extends StatefulHookConsumerWidget {
  const Healtyfy({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HealtyfyState();
}

class _HealtyfyState extends ConsumerState<Healtyfy> {

  List<Widget> pages = [
    const TantanganView(),
    const EdukasiView(),
    const ResepView(),
    const KalkulatorView(),
    const SayaView(),
  ];

  var indexBar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.bgPrimary),
      body: pages.elementAt(indexBar),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            indexBar = value;
          });
        },
        currentIndex: indexBar,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(AppColors.bgPrimary),
        unselectedItemColor: const Color(AppColors.greyColor),
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.clipboardCheck),
            label: 'Tantangan',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.squareEditOutline),
            label: 'Edukasi'
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.foodForkDrink),
            label: 'Resep'
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.calculator),
            label: 'Kalkulator'
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.account),
            label: 'Saya'
          ),
        ],
      ),
    );
  }
}