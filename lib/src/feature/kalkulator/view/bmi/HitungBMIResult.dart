import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/utils/AppColors.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';
import 'package:pretty_gauge/pretty_gauge.dart';

class HitungBMIResult extends ConsumerWidget {
  final int gender;
  final int hasil;

  const HitungBMIResult({
    Key? key,
    required this.gender,
    required this.hasil,
  }) : super(key: key);

  Widget CustomText(String text, int color) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: 20, fontWeight: FontWeight.w600, color: Color(color)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          const AppBarBackWidget(),
          const SizedBox(
            height: 80,
          ),
          Text(
            'Nilai Kamu',
            style:
                GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 38,
          ),
          PrettyGauge(
            gaugeSize: 300,
            minValue: 0,
            maxValue: 40,
            segments: [
              GaugeSegment('Kurus', 18.5, const Color(0xfff24336)),
              GaugeSegment('Normal', 6.4, const Color(0xff4cb050)),
              GaugeSegment('Gemuk', 5, const Color(0xffff9700)),
              GaugeSegment('Obesitas', 10.1, const Color(0xffea1e63)),
            ],
            valueWidget: Text(
              '$hasil',
              style: const TextStyle(fontSize: 40),
            ),
            currentValue: hasil.toDouble(),
            needleColor: Colors.blue,
          ),
          if (gender == 0) ...[
            if (hasil < 18.5) CustomText('Kurus', 0xfff24336),
            if (hasil >= 18.5 && hasil < 24.9) CustomText('Normal', 0xff4cb050),
            if (hasil >= 25 && hasil < 29.9)
              CustomText('Kelebihan Berat Badan', 0xffff9700),
            if (hasil >= 30) CustomText('Obesitas', 0xffea1e63)
          ] else ...[
            if (hasil < 18.5) CustomText('Kurus', 0xfff24336),
            if (hasil >= 18.5 && hasil < 23.9) CustomText('Normal', 0xff4cb050),
            if (hasil >= 24 && hasil < 29.9)
              CustomText('Kelebihan Berat Badan', 0xffff9700),
            if (hasil >= 30) CustomText('Obesitas', 0xffea1e63)
          ],
          const SizedBox(
            height: 14,
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
                onTap: () {
                  Navigator.of(context).pop();
                },
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
                    'Edukasi',
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
