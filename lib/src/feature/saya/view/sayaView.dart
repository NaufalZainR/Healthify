import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SayaView extends StatefulHookConsumerWidget {
  const SayaView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SayaViewState();
}
class _SayaViewState extends ConsumerState<SayaView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('SAYA'),
    );
  }
}