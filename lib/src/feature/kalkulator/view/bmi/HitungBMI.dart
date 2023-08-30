import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/constants/ScreenSize.dart';
import 'package:healtyfy/src/feature/kalkulator/view/bmi/HitungBMIResult.dart';
import 'package:healtyfy/src/feature/kalkulator/view/widgets/BeratPickerWidget.dart';
import 'package:healtyfy/src/feature/kalkulator/view/widgets/JenisPickerWidget.dart';
import 'package:healtyfy/src/feature/kalkulator/view/widgets/UmurPickerWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../utils/AppColors.dart';
import '../widgets/TinggiPickerWidget.dart';

class HitungBMI extends ConsumerStatefulWidget {
  const HitungBMI({super.key});

  @override
  ConsumerState createState() => _HitungBMIState();
}

class _HitungBMIState extends ConsumerState<HitungBMI> {
  var jenisKelaminIndex = 0; // 0 - pria / 1 - wanita
  var sliderValue = 170.0;
  var umurValue = 18;
  var beratValue = 55;

  GlobalKey hitungBMIKey = GlobalKey();

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
              'Hitung BMI',
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
            GestureDetector(
              onTap: () {
                var hitung = beratValue / ((sliderValue.toInt() / 100) * (sliderValue.toInt() / 100));
                ref.read(calculatorRepositoryProvider).saveBMI(hitungBMIKey, double.parse(hitung.toStringAsFixed(1)), jenisKelaminIndex);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HitungBMIResult(
                        gender: jenisKelaminIndex,
                        hasil: double.parse(hitung.toStringAsFixed(1)),
                      ),
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
