import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LencanaView extends StatefulHookConsumerWidget {
  const LencanaView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LencanaViewState();
}
class _LencanaViewState extends ConsumerState<LencanaView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('LENCANA VIEW'),
    );
  }
}