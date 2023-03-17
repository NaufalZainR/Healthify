import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Tumpukan foto dan Container Nama Artikel
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/eggmayo.png"))),
              ),
              Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    child: Icon(Icons.arrow_back, color: Colors.white),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  )),
              Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Bahan-Bahan",
                      style: GoogleFonts.montserrat(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  height: height * .07,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))))
            ],
          ),

          //Bahan Bahan
          TitleDetail(
              title: "Resep",
              detail:
                  "3 Butir telur \n 2lembar roti tawar gandum \n 20 gr Low Cal Mayo \n Secukupnya lada, paprika bubuk, garam"),

          //Deskipsi
          TitleDetail(
              title: "Cara Membuat",
              detail:
                  "1. Rebus telur 10 menit, angkat, celupkan ke air dingin, kupas kulit nya \n 2. Tambahkan bumbu: lada, paprika bubuk,garam secukupnya \n 3. Tambahkan mayo \n 4. Campur dan haluskan \n 5. Panggang roti tawar \n 6. Letakkan campuran telur ke atas roti, tutup \n "),
        ],
      )),
    );
  }
}

class TitleDetail extends StatelessWidget {
  final String title;
  final String detail;
  const TitleDetail({Key? key, required this.title, required this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
                fontSize: 12, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(detail, style: GoogleFonts.montserrat(fontSize: 12))
        ],
      ),
    );
  }
  
}
