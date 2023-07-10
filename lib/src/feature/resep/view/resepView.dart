import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widgets/AppBarWidget.dart';

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
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(),
        ),
      ],
    );
  }
}
