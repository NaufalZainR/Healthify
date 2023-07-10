import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilView extends StatefulHookConsumerWidget {
  const ProfilView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ProfilViewState();
}
class ProfilViewState extends ConsumerState<ProfilView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profil View')
    );
  }
}