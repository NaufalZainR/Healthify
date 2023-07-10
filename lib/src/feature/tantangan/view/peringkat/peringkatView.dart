import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PeringkatView extends StatefulHookConsumerWidget {
  const PeringkatView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => PeringkatViewState();
}
class PeringkatViewState extends ConsumerState<PeringkatView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Peringkat View'),
    );
  }
}