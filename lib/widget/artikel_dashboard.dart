import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Artikel extends StatelessWidget {
  final String imagePath;
  final String deskripsi;
  const Artikel({
    Key? key,
    required this.imagePath,
    required this.deskripsi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 240,
        child: Stack(
          children: [
            Card(
              elevation: 7,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 150,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                left: 10,
                child: SizedBox(
                  height: 70,
                  child: Column(children: [
                    Text(deskripsi, style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.bold),),
                  ],),
                )),
          ],
        ));
  }
}