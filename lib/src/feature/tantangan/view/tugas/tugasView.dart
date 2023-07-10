import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TugasView extends StatefulHookConsumerWidget {
  const TugasView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TugasViewState();
}
class _TugasViewState extends ConsumerState<TugasView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Tugas view'),
    );
  }
}