import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/feature/kalkulator/view/kalori/HitungKaloriResult.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    'Olahraga 1-3x/minggu (Ringan)',
    'Olahraga 3-5x/minggu (Sedang)',
    'Olahraga 6-7x/minggu (Berat)',
    'Olahraga 2x/hari (Fisik)',
  ];

  @override
  void initState() {
    super.initState();
    getLastValue();
  }

  void getLastValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      jenisKelaminIndex = pref.getInt('jenisKelaminIndexLast') ?? 0;
      sliderValue = pref.getDouble('tinggiLast') ?? 170.0;
      umurValue = pref.getInt('umurLast') ?? 18;
      beratValue = pref.getInt('beratLast') ?? 55;
    });
  }

  void setLastValue(int value, int check, double valueD) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (check == 1) {
      pref.setInt('jenisKelaminIndexLast', value);
    } else if (check == 2) {
      pref.setDouble('tinggiLast', valueD);
    } else if (check == 3) {
      pref.setInt('umurLast', value);
    } else if (check == 4) {
      pref.setInt('beratLast', value);
    }
  }

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
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
            JenisPickerWidget(
              value: jenisKelaminIndex,
              onTap: (value) {
                setState(() {
                  jenisKelaminIndex = value;
                  setLastValue(jenisKelaminIndex, 1, 0);
                });
              },
            ),
            TinggiPickerWidget(
              value: sliderValue,
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                  setLastValue(0, 2, sliderValue);
                });
              },
            ),
            const SizedBox(
              height: 46,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                UmurPickerWidget(
                  value: umurValue,
                  onChanged: (value) {
                    setState(() {
                      umurValue = value;
                      setLastValue(umurValue, 3, 0);
                    });
                  },
                ),
                BeratPickerWidget(
                  value: beratValue,
                  onChanged: (value) {
                    setState(() {
                      beratValue = value;
                      setLastValue(beratValue, 4, 0);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 27,
            ),
            DecoratedBox(
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(color: Color.fromARGB(62, 0, 0, 0), blurRadius: 4)
              ]),
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
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 27,
            ),
            GestureDetector(
              onTap: () {
                late var hitung;
                if (jenisKelaminIndex == 0) {
                  hitung = (88.4 + 13.4 * beratValue) +
                      (4.8 * sliderValue.toInt()) -
                      (5.68 * umurValue);
                } else {
                  hitung = (447.6 + 9.25 * beratValue) +
                      (3.10 * sliderValue.toInt()) -
                      (4.33 * umurValue);
                }
                switch (dropdownValue) {
                  case 'Rebahan doang':
                    hitung = hitung * 1;
                    break;
                  case 'Olahraga 1-3x/minggu (Ringan)':
                    hitung = hitung * 1.4;
                    break;
                  case 'Olahraga 3-5x/minggu (Sedang)':
                    hitung = hitung * 1.55;
                    break;
                  case 'Olahraga 6-7x/minggu (Berat)':
                    hitung = hitung * 1.7;
                    break;
                  case 'Olahraga 2x/hari (Fisik)':
                    hitung = hitung * 1.9;
                    break;
                  default:
                    hitung = hitung * 1;
                }
                Snackbar.snackbarShow(context, 'Berhasil dihitung!');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HitungKaloriResult(
                        hasil: hitung,
                      ),
                    ));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 11),
                width: ScreenSize.screenWidth(context),
                decoration: const BoxDecoration(
                    color: Color(AppColors.bgPrimary),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Center(
                  child: Text(
                    'Hitung',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
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
