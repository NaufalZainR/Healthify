import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';

class ResepDetailView extends ConsumerWidget {
  const ResepDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarBackWidget(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Omellete (200 kkal)',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 22,
                ),
                Text(
                  'Resep',
                  style: GoogleFonts.poppins(
                      fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 22,
                ),
                Text(
                  '''
                  3 Butir telur
                  2 lembar roti tawar gandum
                  20 gr Low Cal Mayo 
                  Secukupnya lada, paprika bubuk, garam
                  ''',
                  style: GoogleFonts.poppins(
                      fontSize: 13, fontWeight: FontWeight.normal),
                ),
                Text(
                  'Cara membuat',
                  style: GoogleFonts.poppins(
                      fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 22,
                ),
                Text(
                  '''
                  1. Rebus telur 10 menit, angkat, celupkan ke air dingin, kupas kulit nya
                  2. Tambahkan bumbu: lada, paprika bubuk, garam secukupnya
                  3. Tambahkan mayo
                  4. Campur dan haluskan
                  5. Panggang roti tawar
                  6. Letakkan campuran telur ke atas roti, tutup
                  ''',
                  style: GoogleFonts.poppins(
                      fontSize: 13, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
