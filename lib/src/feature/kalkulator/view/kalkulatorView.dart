import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class KalkulatorView extends StatefulHookConsumerWidget {
  const KalkulatorView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KalkulatorViewState();
}
class _KalkulatorViewState extends ConsumerState<KalkulatorView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('KALKULATOR'),
    );
  }
}