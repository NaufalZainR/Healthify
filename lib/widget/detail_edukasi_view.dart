import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class detailEdukasi extends StatelessWidget {
  final String title;

  const detailEdukasi({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [Text(title, style: GoogleFonts.montserrat(fontSize: 14))],
      ),
    );
  }
}