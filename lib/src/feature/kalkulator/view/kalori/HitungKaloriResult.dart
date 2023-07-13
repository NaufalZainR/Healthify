import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/AppColors.dart';
import '../../../../widgets/AppBarBackWidget.dart';

class HitungKaloriResult extends ConsumerWidget {
  const HitungKaloriResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          const AppBarBackWidget(),
          const SizedBox(
            height: 99,
          ),
          Text(
            'Nilai Kamu',
            style:
                GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 38,
          ),
          Text(
            '2000 KKAL',
            style: GoogleFonts.poppins(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: const Color(AppColors.fontOrange)),
          ),
          const SizedBox(
            height: 38,
          ),
          Text(
            'Selamat! Pertahankan BMI kamu dengan terus melakukan pola hidup sehat',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  width: 135,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                      color: Color(AppColors.bgPrimary),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: Text(
                    'Hitung Ulang',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 22,
              ),
              GestureDetector(
                child: Container(
                  width: 135,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                      color: Color(AppColors.bgPrimary),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: Text(
                    'Resep',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
