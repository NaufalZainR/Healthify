import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:healtyfy/src/feature/edukasi/view/EdukasiView.dart';
import 'package:healtyfy/src/feature/kalkulator/view/KalkulatorView.dart';
import 'package:healtyfy/src/feature/resep/view/ResepView.dart';
import 'package:healtyfy/src/feature/saya/view/SayaView.dart';
import 'package:healtyfy/src/feature/tantangan/view/TantanganView.dart';
import 'package:healtyfy/src/utils/AppColors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Healtyfy extends StatefulHookConsumerWidget {
  int index;

  Healtyfy({super.key, this.index = 0});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HealtyfyState();
}

class _HealtyfyState extends ConsumerState<Healtyfy> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  List<Widget> pages = [
    const TantanganView(),
    const EdukasiView(),
    const ResepView(),
    const KalkulatorView(),
    const SayaView(),
  ];

  late var indexBar;

  @override
  void initState() {
    super.initState();
    indexBar = widget.index;
    repeatTask();
  }

  void repeatTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final getCurrentTime = DateFormat('dd-MM-yyyy').format(DateTime.now());
    final getSavedTime = prefs.getString('savedTime') ??
        DateFormat('dd-MM-yyyy').format(DateTime.now());

    if (getCurrentTime.toString() != getSavedTime.toString()) {
      prefs.setString('savedTime', getCurrentTime.toString());
      await dbReference
          .child('users')
          .child(auth.currentUser!.uid)
          .child('id_tugas')
          .remove();
    }
  }

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
              icon: Icon(MdiIcons.squareEditOutline), label: 'Edukasi'),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.foodForkDrink), label: 'Resep'),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.calculator), label: 'Kalkulator'),
          BottomNavigationBarItem(icon: Icon(MdiIcons.account), label: 'Saya'),
        ],
      ),
    );
  }
}
