import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EdukasiView extends StatefulHookConsumerWidget {
  const EdukasiView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EdukasiViewState();
}
class _EdukasiViewState extends ConsumerState<EdukasiView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('EDUKASI'),
    );
  }
}