import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/feature/auth/view/widget/textFieldWidget.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';

import '../../../../utils/AppColors.dart';

class TambahCatatanView extends ConsumerStatefulWidget {
  const TambahCatatanView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => TtambahCatatanViewState();
}

class TtambahCatatanViewState extends ConsumerState<TambahCatatanView> {
  GlobalKey tambahCttKey = GlobalKey();
  var catatanValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppBarBackWidget(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextFieldWidget(
                    labelTitle: 'Catatan',
                    labelField: 'Masukkan catatan',
                    onChanged: (value){
                      setState(() {
                        catatanValue = value;
                      });
                    }
                  ),
                  const SizedBox(height: 22,),
                  GestureDetector(
                    onTap: () {
                      ref.read(tugasRepositoryProvider).saveCatatan(tambahCttKey, catatanValue);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 54,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: Color(AppColors.bgPrimary),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Center(
                        child: Text(
                          'Tambah',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(AppColors.fontWhite)
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}