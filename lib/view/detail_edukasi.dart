import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/widget/detail_edukasi_view.dart';

class DetailEdukasi extends StatelessWidget {
  const DetailEdukasi({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: height * 0.4,
                width: width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/mangkoksehat.png"))),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      child: Icon(Icons.arrow_back),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))))),
            ],
          ),
          Container(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text("Pentingnya menjaga pola makan",
                    style: GoogleFonts.montserrat(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              height: height * .07,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)))),

          //Text
          detailEdukasi(
              title:
                  "Pola makan yang tidak terjaga dapat menyebabkan seseorang mengalami obesitas atau kelebihan berat badan, bahkan ada efek yang lebih serius lagi yaitu seseorang dapat terkena berbagaimacam penyakit berbahaya dapat menyebabkan kematian"),
          detailEdukasi(
              title:
                  "Menurut WHO bahwa orang yang mengalami obesitas memilik dampak kesehatan yang berbeda dibandingkandengan orang yang memiliki berat badannormal atau sehat. Obesitas berisiko lebih tinggi terhadap banyak penyakit serius.")
        ],
      )),
    );
  }
}
