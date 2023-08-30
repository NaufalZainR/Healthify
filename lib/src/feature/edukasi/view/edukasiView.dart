import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/widgets/CustomBigTileWidget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widgets/AppBarWidget.dart';
import '../model/EdukasiModel.dart';

class EdukasiView extends StatefulHookConsumerWidget {
  const EdukasiView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EdukasiViewState();
}
class _EdukasiViewState extends ConsumerState<EdukasiView> {
  GlobalKey edukasiKey = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  List<String> tabItem = [
    'All',
    'Berita',
    'Artikel',
    'Video'
  ];

  var selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarWidget(
          tabItem: tabItem,
          selectedCallback: (value){
            setState(() {
              selectedTab = value;
            });
          }
        ),
        StreamBuilder(
          stream: dbReference.child('list_edukasi').onValue,
          builder: (context, snapshot) {
            ref.read(edukasiRepositoryProvider).fetchListEdukasi(edukasiKey, snapshot);
            final data = ref.read(edukasiRepositoryProvider).listEdukasi;
            return Expanded(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(15.0),
                child: ListView.separated(
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    if (selectedTab == 0) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: CustomBigTileWidget(
                            title: data[index].title,
                            namaKategori: data[index].kategori,
                            tabCheck: 'edukasi',
                            imagePath: '',
                        ),
                      );
                    }
                    if (selectedTab == 1 && data[index].kategori.toLowerCase() == 'berita') {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: CustomBigTileWidget(
                            title: data[index].title,
                            namaKategori: data[index].kategori,
                            tabCheck: 'edukasi',
                            imagePath: '',
                        ),
                      );
                    }
                    if (selectedTab == 2 && data[index].kategori.toLowerCase() == 'artikel') {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: CustomBigTileWidget(
                            title: data[index].title,
                            namaKategori: data[index].kategori,
                            tabCheck: 'edukasi',
                            imagePath: '',
                        ),
                      );
                    }
                    if (selectedTab == 3 && data[index].kategori.toLowerCase() == 'video') {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: CustomBigTileWidget(
                            title: data[index].title,
                            namaKategori: data[index].kategori,
                            tabCheck: 'edukasi',
                            imagePath: '',
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox();
                  },
                  itemCount: data.length,
                  physics: const BouncingScrollPhysics(),
                ),
              ),
            );
          }
        ),
      ],
    );
  }
}