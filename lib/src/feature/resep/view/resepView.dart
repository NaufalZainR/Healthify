import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widgets/AppBarWidget.dart';
import '../../../widgets/CustomBigTileWidget.dart';

class ResepView extends StatefulHookConsumerWidget {
  const ResepView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResepViewState();
}

class _ResepViewState extends ConsumerState<ResepView> {
  List<String> tabItem = ['All', 'Sarapan', 'Makan Siang', 'Makan Malam'];

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
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(15.0),
            child: ListView.separated(
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                return CustomBigTileWidget(
                  title: 'makanan ber gizi',
                  subTitle: '200 kkal',
                  tabCheck: 'resep',
                  namaKategori: 'Sarapan',
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 15,
                );
              },
              itemCount: 10,
              physics: const BouncingScrollPhysics(),
            ),
          ),
        ),
      ],
    );
  }
}
