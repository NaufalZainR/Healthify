import 'package:flutter/material.dart';
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
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(),
        ),
      ],
    );
  }
}