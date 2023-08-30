import 'package:flutter/material.dart';
import 'package:healtyfy/src/widgets/CustomBigTileWidget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widgets/AppBarWidget.dart';

class EdukasiView extends StatefulHookConsumerWidget {
  const EdukasiView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EdukasiViewState();
}
class _EdukasiViewState extends ConsumerState<EdukasiView> {
  List<String> tabItem = [
    'All',
    'Berita',
    'Artikel',
    'Video'
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
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(15.0),
            child: ListView.separated(
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                return CustomBigTileWidget(
                    title: 'Berita saat ini',
                    tabCheck: 'edukasi',
                    namaKategori: 'Berita',
                    imagePath: '',
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 15,);
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