import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/feature/resep/model/ResepModel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widgets/AppBarWidget.dart';
import '../../../widgets/CustomBigTileWidget.dart';
import 'ResepDetailView.dart';

class ResepView extends StatefulHookConsumerWidget {
  const ResepView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResepViewState();
}

class _ResepViewState extends ConsumerState<ResepView> {
  GlobalKey resepKey = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  List<String> tabItem = ['All', 'Sarapan', 'Makan Siang', 'Makan Malam'];

  var selectedTab = 0;

  Widget showList(List<ResepModel> data, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResepDetailView(
                      data: data[index],
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: CustomBigTileWidget(
          title: data[index].title,
          subTitle: data[index].subtitle,
          namaKategori: data[index].kategori,
          imagePath: '',
          tabCheck: 'resep',
        ),
      ),
    );
  }

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
        StreamBuilder(
            stream: dbReference.child('list_resep').onValue,
            builder: (context, snapshot) {
              ref
                  .read(resepRepositoryProvider)
                  .fetchListResep(resepKey, snapshot);
              final data = ref.read(resepRepositoryProvider).listResep;
              return Expanded(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      if (selectedTab == 0) {
                        return showList(data, index);
                      }
                      if (selectedTab == 1 &&
                          data[index].kategori.toLowerCase() == 'sarapan') {
                        return showList(data, index);
                      }
                      if (selectedTab == 2 &&
                          data[index].kategori.toLowerCase() == 'makan siang') {
                        return showList(data, index);
                      }
                      if (selectedTab == 3 &&
                          data[index].kategori.toLowerCase() == 'makan malam') {
                        return showList(data, index);
                      }
                      return const SizedBox();
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 0,
                      );
                    },
                    itemCount: data.length,
                    physics: const BouncingScrollPhysics(),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
