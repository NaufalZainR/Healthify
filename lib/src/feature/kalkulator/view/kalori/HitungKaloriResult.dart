import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/feature/kalkulator/view/kalori/HitungKaloriRiwayat.dart';
import 'package:healtyfy/src/healtyfy.dart';

import '../../../../utils/AppColors.dart';
import '../../../../widgets/AppBarBackWidget.dart';

class HitungKaloriResult extends ConsumerWidget {
  double hasil;

  HitungKaloriResult({
    super.key,
    this.hasil = 0
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const AppBarBackWidget(),
            const SizedBox(height: 99,),
            Text(
              'Kalori harian kamu',
              style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(height: 38,),
            Text(
              '${hasil.toInt()} KKAL',
              style: GoogleFonts.poppins(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: const Color(AppColors.fontOrange)
              ),
            ),
            const SizedBox(height: 38,),
            Text(
              'Jangan lupa makan sesuai dengan kalori harian kamu',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 14,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 135,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                        color: Color(AppColors.bgPrimary),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                    child: Text(
                      'Hitung Ulang',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 22,),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Healtyfy(index: 2,)
                      )
                    );
                  },
                  child: Container(
                    width: 135,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                        color: Color(AppColors.bgPrimary),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                    child: Text(
                      'Resep',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HitungKaloriRiwayat()
                  )
                );
              },
              child: Container(
                width: 135,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                    color: Color(AppColors.bgPrimary),
                    borderRadius: BorderRadius.all(Radius.circular(6))
                ),
                child: Text(
                  'Riwayat',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                  ),
                ),
              ),
            ),
            const SizedBox(height: 38,),
          ],
        ),
      ),
    );
  }
}
