import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/feature/kalkulator/view/kalori/HitungKaloriResult.dart';

import '../../../../constants/ScreenSize.dart';
import '../../../../utils/AppColors.dart';
import '../../../../utils/Snackbar.dart';
import '../widgets/BeratPickerWidget.dart';
import '../widgets/JenisPickerWidget.dart';
import '../widgets/TinggiPickerWidget.dart';
import '../widgets/UmurPickerWidget.dart';

class HitungKalori extends ConsumerStatefulWidget {
  const HitungKalori({super.key});

  @override
  ConsumerState createState() => _HitungKaloriState();
}

class _HitungKaloriState extends ConsumerState<HitungKalori> {
  var jenisKelaminIndex = 0; // 0 - pria / 1 - wanita
  var sliderValue = 170.0;
  var umurValue = 18;
  var beratValue = 55;
  var dropdownValue = 'Rebahan doang';

  List itemsDropdown = [
    'Rebahan doang',
    'Aktivitas ringan',
    'Aktivitas menengah',
    'Aktivitas berat',
    'Aktivitas fisik',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: ScreenSize.screenWidth(context),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Hitung Kalori Harian',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),
            ),
            JenisPickerWidget(
              onTap: (value){
                setState(() {
                  jenisKelaminIndex = value;
                });
              },
            ),
            TinggiPickerWidget(
              onChanged: (value){
                setState(() {
                  sliderValue = value;
                });
              },
            ),
            const SizedBox(height: 46,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                UmurPickerWidget(
                  onChanged: (value){
                    setState(() {
                      umurValue = value;
                    });
                  },
                ),
                BeratPickerWidget(
                  onChanged: (value){
                    setState(() {
                      beratValue = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 27,),
            DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(62, 0, 0, 0),
                    blurRadius: 4
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: DropdownButton(
                  value: dropdownValue,
                  items: itemsDropdown.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  isExpanded: true,
                  underline: Container(),
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
            const SizedBox(height: 27,),
            GestureDetector(
              onTap: () {
                late var hitung;
                if(jenisKelaminIndex == 0){
                  hitung = (88.4 + 13.4 * beratValue) + (4.8 * sliderValue.toInt()) - (5.68 * umurValue);
                  debugPrint('DEBUG ${hitung}');
                } else {
                  hitung = (447.6 + 9.25 * beratValue) + (3.10 * sliderValue.toInt()) - (4.33 * umurValue);
                  debugPrint('DEBUG ${hitung}');
                }
                switch (dropdownValue) {
                  case 'Rebahan doang':
                  hitung = hitung * 1;
                    break;
                  case 'Aktivitas ringan':
                  hitung = hitung * 1.4;
                    break;
                  case 'Aktivitas menengah':
                  hitung = hitung * 1.55;
                    break;
                  case 'Aktivitas berat':
                  hitung = hitung * 1.7;
                    break;
                  case 'Aktivitas fisik':
                  hitung = hitung * 1.9;
                    break;
                  default:
                  hitung = hitung * 1;
                }
                ref.read(calculatorRepositoryProvider).saveKalori(context, (hitung.toInt()).toString());
                Snackbar.snackbarShow(context, 'Berhasil dihitung!');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HitungKaloriResult(hasil: hitung,),
                    )
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 11),
                width: ScreenSize.screenWidth(context),
                decoration: const BoxDecoration(
                    color: Color(AppColors.bgPrimary),
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Center(
                  child: Text(
                    'Hitung',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
