import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResepView extends StatefulHookConsumerWidget {
  const ResepView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResepViewState();
}
class _ResepViewState extends ConsumerState<ResepView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('RESEP'),
    );
  }
}